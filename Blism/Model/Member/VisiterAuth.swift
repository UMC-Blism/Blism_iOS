//
//  VisiterAuth.swift
//  Blism
//
//  Created by 이수현 on 12/21/24.
//

import Foundation

public struct VisiterAuthRequest: Codable {
    let nickname: String
    let checkCode: String
}


public struct VisiterAuthResponse: Codable {
    let isSucess: Bool
    let code: Int
    let message: String
    let result: VisitierAuthData
}


public struct VisitierAuthData: Codable {
    let mailBoxId: Int
    
    enum CodingKeys: String, CodingKey {
        case mailBoxId = "mailbox_id"
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.mailBoxId = try container.decode(Int.self, forKey: .mailBoxId)
    }
}

/*
 {
   "isSuccess": true,
   "code": 0,
   "message": "string",
   "result": {
     "mailbox_id": 0
   }
 }
 */
