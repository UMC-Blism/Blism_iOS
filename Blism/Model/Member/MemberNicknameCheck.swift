//
//  MemberNicknameCheck.swift
//  Blism
//
//  Created by 이수현 on 12/20/24.
//

import Foundation

public struct MemberNicknameCheckRequest: Encodable {
    let nickname: String
}

/*
 {
     "nickname" : "김가천" (String)
 }
 */


public struct MemberNicknameCheckResponse: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: MemberNicknameCheckData?
    
    enum CodingKeys: String, CodingKey {
        case isSuccess
        case code
        case message
        case result
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.isSuccess = try container.decode(Bool.self, forKey: .isSuccess)
        self.code = try container.decode(Int.self, forKey: .code)
        self.message = try container.decode(String.self, forKey: .message)
        self.result = try container.decodeIfPresent(MemberNicknameCheckData.self, forKey: .result) ?? nil
    }
}

public struct MemberNicknameCheckData: Decodable {
    let nickname: String
    let memberId: Int64
    
    enum CodingKeys: String, CodingKey {
        case nickname
        case memberId = "id"
    }
   
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.nickname = try container.decode(String.self, forKey: .nickname)
        self.memberId = try container.decode(Int64.self, forKey: .memberId)
    }
}

/*
 { // 닉네임이 중복 되었을 때

     isSuccess: True,
     code: 200,
     message: "넥네임 중복 조회 성공",
     result: {
         "nickname": "윤지석" (String),
     "member_id": 1 (Long)
     }
 }
 */
