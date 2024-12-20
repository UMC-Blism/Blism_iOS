//
//  SpecificPastMailboxResponse.swift
//  Blism
//
//  Created by 송재곤 on 12/20/24.
//

struct SpecificPastMailboxResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let data: UserData
}

struct UserData: Codable {
    let memberId: Int
    let count: Int
    let letters: [PastletterData]
}

struct PastletterData: Codable {
    let letterId: Int
    let doorDesign: Int
    let colorDesign: Int
    let decorationDesign: Int
    let visibility: Bool
}
