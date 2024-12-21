//
//  LetterTargetType.swift
//  Blism
//
//  Created by 이재혁 on 12/21/24.
//

import UIKit
import Foundation
import Moya

enum LetterTargetType {
    case writeLetter(image: UIImage, WriteLetterRequest)    // 편지 작성
    case readLetter(letterID: Int64)        // 특정 편지 조회
    case readAllLetters                     // 전체 편지 조회
    case readAllReceivedLetters             // 받은 전체 편지 조회
    // case editLetter // 편지 수정
}

extension LetterTargetType: TargetType {
    var baseURL: URL {
        guard let baseURL = URL(string: "http://3.38.95.210:8080") else {
            fatalError("Error: Invalid URL")
        }
        
        return baseURL
    }
    
    var path: String {
        switch self {
        case .writeLetter:
            return "/letters"
        case .readLetter(let letterID):
            return "/letters/\(letterID)"
        case .readAllLetters:
            return "/letters/sent"
        case .readAllReceivedLetters:
            return "/letters/received"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .writeLetter:
            return .post
        case .readLetter(_), .readAllLetters, .readAllReceivedLetters:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .writeLetter(let image, let request):
            // 이미지 데이터를 Data로 변환
            guard let imageData = image.jpegData(compressionQuality: 0.8) else {
                return .requestPlain
            }
            
            var formData: [MultipartFormData] = []
            
            // 이미지 추가
            let imagePart = MultipartFormData(
                provider: .data(imageData),
                name: "image",
                fileName: "image.jpg",
                mimeType: "image/jpeg"
            )
            formData.append(imagePart)
            
            // Request body(createLetterRequestDTO)를 JSON으로 인코딩
            do {
                let jsonData = try JSONEncoder().encode(request)
                let requestPart = MultipartFormData(
                    provider: .data(jsonData),
                    name: "createLetterRequestDTO",
                    mimeType: "application/json"
                )
                formData.append(requestPart)
            } catch {
                print("Failed to encode request body: \(error)")
                return .requestPlain
            }
            
            return .uploadMultipart(formData)
        case .readLetter(_), .readAllLetters, .readAllReceivedLetters:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .writeLetter:
            return ["Content-Type": "multipart/form-data"]
        case .readLetter(_), .readAllLetters:
            return ["Content-Type": "application/json"]
        case .readAllReceivedLetters:
            return .none
        }
    }
    
}

