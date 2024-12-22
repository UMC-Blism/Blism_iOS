//
//  ReplyLetter.swift
//  Blism
//
//  Created by 이재혁 on 12/22/24.
//

import Foundation
import UIKit

final class ReplyLetterData {
    static let shared = ReplyLetterData()
    
    private init() {}
    
    var content: String = ""
    var letter_id: Int64 = 0
    var font: Int = 0
    var sender_id: Int64 = 0
    var receiver_id: Int64 = 0
    var mailbox_id: Int64 = 0
    var attachedImage: UIImage? = nil
}

public struct ReplyLetterRequest: Codable {
    let content: String
    let letter_id: Int64
    let font: Int
    let sender_id: Int64
    let receiver_id: Int64
    let mailbox_id: Int64
}

public struct ReplyLetterResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: String
}
