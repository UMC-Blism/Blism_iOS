//
//  FetchReceivedLetters.swift
//  Blism
//
//  Created by 이재혁 on 12/22/24.
//

import Foundation

// 특정 사용자가 받은 모든 편지 조회

// MARK: - FetchReceivedLetters Request
public struct FetchReceivedLettersRequest: Codable {
    let userId: Int64
}

// MARK: - Response
struct FetchReceivedLettersResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [FetchReceivedLettersResponseData]
}

// MARK: - ~ Data
struct FetchReceivedLettersResponseData: Codable {
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

/**
 private func testFetchReceivedLetters(userId: Int64) {
     let request = FetchReceivedLettersRequest(userId: userId)
     LetterRequest.shared.fetchReceivedLetters(request: request) {[weak self] result in
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
