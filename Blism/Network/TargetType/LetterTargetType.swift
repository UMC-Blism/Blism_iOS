//
//  LetterTargetType.swift
//  Blism
//
//  Created by 이재혁 on 12/21/24.
//

import Foundation
import Moya

enum LetterTargetType {
    // case writeLetter // 편지 작성
    case readLetter(letterID: Int64) // 편지 조회
    case readAllLetters // 전체 편지 조회
    case readAllReceivedLetters // 받은 전체 편지 조회
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
        case .readLetter(_), .readAllLetters, .readAllReceivedLetters:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .readLetter(_), .readAllLetters, .readAllReceivedLetters:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .readLetter(_), .readAllLetters:
            return ["Content-type": "application/json"]
        case .readAllReceivedLetters:
            return .none
        }
    }
    
}
