//
//  Untitled.swift
//  Blism
//
//  Created by 송재곤 on 12/20/24.
//

import Foundation

struct OtherPersonMailboxResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let data: otherPersonMailbox
}
struct otherPersonMailbox: Codable {
    let memberId: Int
    let count: Int
    let letters: [otherPersonLetterData]
}

struct otherPersonLetterData: Codable {
    let letterId: Int
    let doorDesign: Int
    let colorDesign: Int
    let decorationDesign: Int
    let visibility: Bool
}

