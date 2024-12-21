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
    let isSucess: Bool
    let code: Int
    let message: String
    let result: VisitiorAuthData?
    
    enum CodingKeys: String, CodingKey {
        case isSucess
        case code
        case message
        case result
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.isSucess = try container.decode(Bool.self, forKey: .isSucess)
        self.code = try container.decode(Int.self, forKey: .code)
        self.message = try container.decode(String.self, forKey: .message)
        self.result = try container.decodeIfPresent(VisitiorAuthData.self, forKey: .result)
    }
}


public struct VisitiorAuthData: Codable {
    let mailBoxId: Int
    
    enum CodingKeys: String, CodingKey {
        case mailBoxId = "mailbox_id"
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.mailBoxId = try container.decode(Int.self, forKey: .mailBoxId)
    }
}

//{
//  "isSuccess": true,
//  "code": 200,
//  "message": "성공입니다.",
//  "result": {
//    "mailbox_id": 1
//  }
//}
