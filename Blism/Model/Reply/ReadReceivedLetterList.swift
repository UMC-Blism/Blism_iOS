//
//  ReadReceivedLetterList.swift
//  Blism
//
//  Created by 이수현 on 12/21/24.
//

import Foundation

public struct ReadReceivedLetterListRequest: Codable {
    let memberid: Int64
}

public struct ReadReceivedLetterListResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [ReceivedLetterListData]?
    
    enum CodingKeys: CodingKey {
        case isSuccess
        case code
        case message
        case result
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.isSuccess =  try container.decode(Bool.self, forKey: .isSuccess)
        self.code = try container.decode(Int.self, forKey: .code)
        self.message = try container.decode(String.self, forKey: .message)
        self.result = try container.decodeIfPresent([ReceivedLetterListData].self, forKey: .result)
    }
}

public struct ReceivedLetterListData: Codable {
    let letterId : Int64
    let content: String
    let senderId: Int64
    let senderName: String
    let createdDate : String
    
    enum CodingKeys: String, CodingKey {
        case letterId = "letter_id"
        case content
        case senderId = "sender_id"
        case senderName = "sender_name"
        case createdDate = "created_at"
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.letterId = try container.decode(Int64.self, forKey: .letterId)
        self.content = try container.decode(String.self, forKey: .content)
        self.senderId = try container.decode(Int64.self, forKey: .senderId)
        self.senderName = try container.decode(String.self, forKey: .senderName)
        
        let dateString = try container.decode(String.self, forKey: .createdDate)
        let ISOFormatter = ISO8601DateFormatter()
        
        guard let parsedDate = ISOFormatter.date(from: dateString) else {
            self.createdDate = "날짜 디코딩 실패"
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy⋅MM⋅dd⋅EEE"
        self.createdDate = dateFormatter.string(from: parsedDate)
    }
    
    
}


/*
 {
   "isSuccess": true,
   "code": 0,
   "message": "string",
   "result": [
     {
       "letter_id": 0,
       "content": "string",
       "receiver_id": 0,
       "receiver_name": "string"
     }
   ]
 }
 */
