//
//  MemberChangeNickname.swift
//  Blism
//
//  Created by 이수현 on 12/20/24.
//

import Foundation

public struct MemberChangeNicknameRequest: Codable {
    let originalNickname: String
    let newNickname: String
    
    public enum CodingKeys: String, CodingKey {
        case originalNickname = "original_nickname"
        case newNickname = "new_nickname"
    }
}

/*
 {
     "original_nickname" : "김가천" (String,
     "new_nickname" : "김무당" (String)
 }
 */


public struct MemberChangeNicknameReponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let data: MemberChangeNicknameData?
}

public struct MemberChangeNicknameData: Codable{
    let nickname: String
}

/*
 {

     isSuccess: True,
     code: 200,
     message: "넥네임 수정 성공",
     data: {
         "nickname" : "변경 가천" (String)
     }
 }
 */
