//
//  NetworkError.swift
//  Blism
//
//  Created by 이수현 on 12/21/24.
//

import Foundation

public enum NetworkError: Error {
    case urlError                // URL 에러
    case dataNil                 // 데이터 없음
    case invalidResponse        // 유효하지 않은 응답
    case failToDecode(String)        // 디코딩 에러
    case serverError(Int)       // 서버 에러
    case requestFailed  // 요청 실패
}


extension NetworkError {
    var description: String {
        switch self {
        case .urlError:
            "URL이 올바르지 않습니다."
        case .dataNil:
            "데이터가 없습니다."
        case .invalidResponse:
            "응답 값이 유효하지 않습니다."
        case .failToDecode(let description):
            "디코딩 에러: \(description)"
        case .serverError(let statusCode):
            "\(statusCode) 서버 에러"
        case .requestFailed:
            "서버 요청 실패"
        }
    }
}
