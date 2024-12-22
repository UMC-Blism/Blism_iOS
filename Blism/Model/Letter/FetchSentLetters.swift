//
//  FetchSentLetters.swift
//  Blism
//
//  Created by 이재혁 on 12/22/24.
//

import Foundation

// 특정 사용자가 보낸 모든 편지 조회

// MARK: - FetchSentLetters Request
public struct FetchSentLettersRequest: Codable {
    let userId: Int64
}

// MARK: - RESponse
struct FetchSentLettersResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [FetchSentLettersResponseData]
}

// MARK: - ~ Data
struct FetchSentLettersResponseData: Codable {
    let letterId: Int64
    let senderId: Int64
    let receiverId: Int64
    let senderNickname: String
    let receiverNickname: String
    let content: String
    let photoUrl: String
    let font: Int
    let visibility: Int
    let createdAt: String
}

/**
 private func testFetchSentLetters(userId: Int64) {
     let request = FetchSentLettersRequest(userId: userId)
     LetterRequest.shared.fetchSentLetters(request: request) {[weak self] result in
         switch result {
         case .success(let data):
             print(data)
         case .failure(let error):
             let alert = NetworkAlert.shared.getAlertController(title: error.description)
             self?.present(alert, animated: true)
         }
     }
 }
 */
