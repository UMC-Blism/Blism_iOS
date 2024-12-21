//
//  MemberSearch.swift
//  Blism
//
//  Created by 이수현 on 12/21/24.
//

import Foundation


public struct MemberSearchRequest: Codable {
    let nickname: String
}


public struct MemberSearchResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [MemberSearchResponseData]
}

public struct MemberSearchResponseData: Codable {
    let memberId : Int64
    let nickname: String
    
    enum CodingKeys: String, CodingKey {
        case memberId = "member_id"
        case nickname
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.memberId = try container.decode(Int64.self, forKey: .memberId)
        self.nickname = try container.decode(String.self, forKey: .nickname)
    }
}


/*
 {
   "isSuccess": true,
   "code": 200,
   "message": "성공입니다.",
   "result": [
     {
       "member_id": 3,
       "nickname": "dd"
     },
     {
       "member_id": 4,
       "nickname": "Did"
     }
   ]
 }
 */
