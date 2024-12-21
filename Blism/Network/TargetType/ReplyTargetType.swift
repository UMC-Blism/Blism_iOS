//
//  ReplyTargetType.swift
//  Blism
//
//  Created by 이수현 on 12/20/24.
//

import Foundation
import Moya

public enum ReplyTargetType {
    case reply                  // 편지 작성하기
    case readAllSentReply         // 내가 보낸 답장 조회
    case readAllReceivedReply      // 내가 받은 답장 조회
    case readDetailReply          // 편지 디테일 조회
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
            return "/replies"
        case .readAllSentReply:
            return "/replies/sent"
        case .readAllReceivedReply:
            return "/replies/received"
        case .readDetailReply:
            return "/replies"
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
        case .reply:
            return .requestPlain
        case .readAllSentReply:
            return .requestPlain
        case .readAllReceivedReply:
            return .requestPlain
        case .readDetailReply:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    
}
