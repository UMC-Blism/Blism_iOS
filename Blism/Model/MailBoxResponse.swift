//
//  MailBoxCollectionViewApiModel.swift
//  Blism
//
//  Created by 송재곤 on 12/20/24.
//

import Foundation

struct MailBoxResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let data: letterData
}

struct letterData: Codable {
    let memberId: Int
    let count: Int
    let letters: [Letter]
}

struct Letter: Codable {
    let letterId: Int
    let doorDesign: Int
    let colorDesign: Int
    let decorationDesign: Int
    let visibility: Bool
}
