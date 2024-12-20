//
//  PastMailboxResponse.swift
//  Blism
//
//  Created by 송재곤 on 12/20/24.
//

import Foundation

struct PastMailboxResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let data: mailboxData
}

struct mailboxData: Codable {
    let memberId: Int
    let count: Int
    let mailboxes: [mailboxInfo]
}

struct mailboxInfo: Codable {
    let mailboxId: Int
    let year: Int
}
