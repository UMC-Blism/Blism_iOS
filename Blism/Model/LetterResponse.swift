//
//  LetterResponse.swift
//  Blism
//
//  Created by 이재혁 on 12/21/24.
//

import Foundation

// MARK: - ReadLetter Response
struct ReadLetterResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let data: LetterData?
}

// MARK: - Letter Data (ReadLetter)
struct LetterData: Codable {
    let letterId: Int64
    let content: String
    let photoUrl: String
    let font: Int
    let senderId: Int64
    let senderNickname: String
    let receiverId: Int64
    let receiverNickname: String
    let publicCheck: Bool
}
