//
//  MemberSignUp.swift
//  Blism
//
//  Created by 이수현 on 12/20/24.
//

import Foundation


public struct MemberSignUpRequest: Codable {
    let nickname: String
    let password: String
}


public struct MemberSignUpResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let data: MemberId?
}

public struct MemberId: Codable {
    let memberId: Int64
    
    enum CodingKeys: String, CodingKey {
        case memberId = "member_id"
    }
   
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.memberId = try container.decode(Int64.self, forKey: .memberId)
    }
}


/*
 {
     isSuccess: True,
     code: 200,
     message: "회원 가입 성공",
     data: {
         "member_id" : 1 (Long)
     }
 }
 */
