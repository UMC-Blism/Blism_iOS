//
//  ReplyTargetType.swift
//  Blism
//
//  Created by 이수현 on 12/20/24.
//

import Foundation
import Moya
import UIKit

public enum ReplyTargetType {
    case reply(image: UIImage, ReplyLetterRequest)        // 편지 작성하기
    case readAllSentReply(ReadSentLetterListRequest)         // 내가 보낸 답장 조회
    case readAllReceivedReply(ReadReceivedLetterListRequest)      // 내가 받은 답장 조회
    case readDetailReply(ReadReplyDetailRequest)   // 편지 디테일 조회
}


extension ReplyTargetType: TargetType {
    public var baseURL: URL {
        guard let baseURL = URL(string: "http://3.38.95.210:8080") else {
            // NetworkError.urlError
           fatalError("Error: Invalid URL")
       }
       return baseURL
    }
    
    public var path: String {
        switch self {
        case .reply:
            return "/replies/"
        case .readAllSentReply:
            return "/replies/{memberId}/sent"
        case .readAllReceivedReply:
            return "/replies/{memberId}/received"
        case .readDetailReply:
            return "/replies{replyid}"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .reply:
            return .post
        case .readAllSentReply:
            return .get
        case .readAllReceivedReply:
            return .get
        case .readDetailReply:
            return .get
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .reply(let image, let request):
            // 이미지 데이터를 Data로 변환
            guard let imageData = image.jpegData(compressionQuality: 0.8) else {
                return .requestPlain
            }
            
            var formData: [MultipartFormData] = []
            
            // 이미지 추가
            let imagePart = MultipartFormData(
                provider: .data(imageData),
                name: "image",
                fileName: "\(image.hashValue).jpg",
                mimeType: "image/jpeg"
            )
            formData.append(imagePart)
            
            // Request body(createLetterRequestDTO)를 JSON으로 인코딩
            do {
                let jsonData = try JSONEncoder().encode(request)
                let requestPart = MultipartFormData(
                    provider: .data(jsonData),
                    name: "request",
                    mimeType: "application/json"
                )
                formData.append(requestPart)
            } catch {
                print("Failed to encode request body: \(error)")
                return .requestPlain
            }
            return .uploadMultipart(formData)
        case .readAllSentReply(let request):
            return .requestParameters(parameters: ["memberid" : request.memberid], encoding: URLEncoding.queryString)
        case .readAllReceivedReply(let request):
            return .requestParameters(parameters: ["memberid" : request.memberid], encoding: URLEncoding.queryString)
        case .readDetailReply(let request):
            return .requestParameters(parameters: ["replyid" : request.replyid], encoding: URLEncoding.queryString)
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .reply:
            return ["Content-Type": "multipart/form-data"]
        default:
            return ["Content-Type": "application/json"]
        }
    }
}
