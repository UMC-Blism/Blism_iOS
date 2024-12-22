//
//  EditLetter.swift
//  Blism
//
//  Created by 이재혁 on 12/22/24.
//

import Foundation
import UIKit

final class EditLetterData {
    static let shared = EditLetterData()
    
    private init() {}
    
    var letterId: Int64 = 0
    var senderId: Int64 = 0
    var receiverId: Int64 = 0
    var mailboxId: Int64 = 0
    var senderNickname: String = ""
    var receiverNickname: String = ""
    var content: String = ""
    var photoUrl: String = ""
    var font: Int = 4
    var visibility: Int = 0
    var doorDesign: Int = 0
    var colorDesign: Int = 0
    var decorationDesign: Int = 0
    var attachedImage: UIImage? = nil
}

public struct EditLetterRequest: Codable {
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

struct EditLetterResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    //let result: String
}