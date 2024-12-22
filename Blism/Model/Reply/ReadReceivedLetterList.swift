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
    let replyId: Int64
    let letterId : Int64
    let content: String
    let senderId: Int64
    let senderName: String
    let createdDate : String
    let font: Int
    
    enum CodingKeys: String, CodingKey {
        case replyId = "reply_id"
        case letterId = "letter_id"
        case content
        case senderId = "sender_id"
        case senderName = "sender_name"
        case createdDate = "created_at"
        case font
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.replyId = try container.decode(Int64.self, forKey: .replyId)
        self.letterId = try container.decode(Int64.self, forKey: .letterId)
        self.content = try container.decode(String.self, forKey: .content)
        self.senderId = try container.decode(Int64.self, forKey: .senderId)
        self.senderName = try container.decode(String.self, forKey: .senderName)
        self.font = try container.decode(Int.self, forKey: .font)
        let dateString = try container.decode(String.self, forKey: .createdDate)
        
        let trimmedDateString = String(dateString.prefix(10)) // "2024-12-22"

        // DateFormatter로 변환
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)

        // 문자열 -> Date 변환
        if let date = dateFormatter.date(from: trimmedDateString) {
            // 변환된 Date를 원하는 형식으로 포맷팅
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "yyyy⋅MM⋅dd⋅EEE요일"
            outputFormatter.locale = Locale(identifier: "ko_KR") // 한국어 요일 표시
            let formattedDate = outputFormatter.string(from: date)
            self.createdDate = formattedDate
        } else {
            self.createdDate = "날짜 변환 실패"
        }
    }
}
/*
 {
   "isSuccess": true,
   "code": 0,
   "message": "string",
   "result": [
     {
       "reply_id": 0,
       "letter_id": 0,
       "content": "string",
       "sender_id": 0,
       "sender_name": "string",
       "created_at": "2024-12-22T07:25:55.233Z",
       "font": 0
     }
   ]
 }
 */
