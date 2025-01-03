//
//  VisitorAuth.swift
//  Blism
//
//  Created by 이수현 on 12/21/24.
//

import Foundation

public struct VisitorAuthRequest: Codable {
    let nickname: String
    let checkCode: String
}


public struct VisitorAuthResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: VisitorAuthData?
    
    enum CodingKeys: String, CodingKey {
        case isSuccess
        case code
        case message
        case result
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.isSuccess = try container.decode(Bool.self, forKey: .isSuccess)
        self.code = try container.decode(Int.self, forKey: .code)
        self.message = try container.decode(String.self, forKey: .message)
        self.result = try container.decodeIfPresent(VisitorAuthData.self, forKey: .result)
    }
}


public struct VisitorAuthData: Codable {
    let mailBoxId: Int64
    let memberId: Int64
    
    enum CodingKeys: String, CodingKey {
        case mailBoxId = "mailbox_id"
        case memberId = "member_id"
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.mailBoxId = try container.decode(Int64.self, forKey: .mailBoxId)
        self.memberId = try container.decode(Int64.self, forKey: .memberId)
    }
}

/*
 {
   "isSuccess": true,
   "code": 200,
   "message": "성공입니다.",
   "result": {
     "mailbox_id": 1,
     "member_id": 1
   }
 }
 */
