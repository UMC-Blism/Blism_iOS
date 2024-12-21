//
//  MemberNicknameCheck.swift
//  Blism
//
//  Created by 이수현 on 12/20/24.
//

import Foundation

public struct MemberNicknameCheckRequest: Codable {
    let nickname: String
}

/*
 {
     "nickname" : "김가천" (String)
 }
 */


public struct MemberNicknameCheckResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let data: MemberNicknameCheckData?
}

public struct MemberNicknameCheckData: Codable {
    let nickname: String
    let memberId: Int64
    
    enum CodingKeys: String, CodingKey {
        case nickname
        case memberId = "member_id"
    }
   
    public init(from decoder: any Decoder) throws {
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
