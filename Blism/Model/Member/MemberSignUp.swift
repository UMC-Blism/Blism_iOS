//
//  MemberSignUp.swift
//  Blism
//
//  Created by 이수현 on 12/20/24.
//

import Foundation


public struct MemberSignUpRequest: Codable {
    let nickname: String
    let checkCode: String
    
    enum CodingKeys: String, CodingKey {
        case nickname
        case checkCode = "check_code"
    }
}

/*
 {
   "nickname": "수",
   "check_code": "1243"
 }
 */


public struct MemberSignUpResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: String?
    
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
        self.result = try container.decodeIfPresent(String.self, forKey: .result) ?? nil
    }
}
/*
 {
   "isSuccess": true,
   "code": 0,
   "message": "string",
   "result": "string"
 }
 */
