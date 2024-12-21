//
//  WriteLetter.swift
//  Blism
//
//  Created by 이재혁 on 12/22/24.
//

import Foundation

public struct WriteLetterRequest: Codable {
    let senderId: Int64
    let receiverId: Int64
    let mailboxId: Int64
    let doorDesign: Int
    let colorDesign: Int
    let decorationDesign: Int
    let content: String
    let font: Int
    let visibility: Int
}

public struct WriteLetterResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
}
