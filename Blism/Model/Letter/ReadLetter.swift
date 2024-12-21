//
//  ReadLetter.swift
//  Blism
//
//  Created by 이재혁 on 12/21/24.
//

import Foundation

// MARK: - ReadLetter Request
public struct ReadLetterRequest: Codable {
    let letterId: Int64
}

// MARK: - ReadLetter Response
struct ReadLetterResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: ReadLetterResponseData
}

// MARK: - Letter Data (ReadLetter)
struct ReadLetterResponseData: Codable {
    let letterId: Int64
    let senderId: Int64
    let receiverId: Int64
    let senderNickname: String
    let receiverNickname: String
    let content: String
    let photoUrl: String
    let font: Int
    let visibility: Int
}

// 이따 연결용
//private func test() {
//    let request = ReadLetterRequest(letterId: Int64(2))
//    LetterRequest.shared.readLetter(request: request) {[weak self] result in
//        switch result {
//        case .success(let data):
//            print("성공: \(data)")
//        case .failure(let error):
//            let alert = NetworkAlert.shared.getAlertController(title: error.description)
//            self?.present(alert, animated: true)
//        }
//    }
//}
