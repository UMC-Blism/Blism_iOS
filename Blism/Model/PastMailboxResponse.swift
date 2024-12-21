//
//  PastMailboxResponse.swift
//  Blism
//
//  Created by 송재곤 on 12/21/24.
//

struct PastMailboxResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let data: mailBoxData
}

struct mailBoxData: Codable {
    let memberId: Int
    let count: Int
    let mailboxes: [pastMailBoxData]
}

struct pastMailBoxData: Codable {
    let mailboxId: Int
    let yeat: Int
}
