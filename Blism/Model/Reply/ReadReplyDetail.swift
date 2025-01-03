//
//  ReadReplyDetail.swift
//  Blism
//
//  Created by 이수현 on 12/22/24.
//

import Foundation

public struct ReadReplyDetailRequest: Codable {
    let replyid: Int64
}

public struct ReadReplyDetailResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: ReadReplyDetailData
}

public struct ReadReplyDetailData: Codable {
    let letterId: Int64
    let content: String
    let senderId: Int64
    let senderName: String
    let receiverId: Int64
    let receiverName: String
    let createdDate: String
    let font: Int
    let photoURL: String
    
    
    enum CodingKeys: String, CodingKey {
        case letterId = "letter_id"
        case content
        case senderId = "sender_id"
        case senderName = "sender_name"
        case receiverId = "receiver_id"
        case receiverName = "receiver_name"
        case createdDate = "created_at"
        case font
        case photoURL = "photo_url"
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.letterId = try container.decode(Int64.self, forKey: .letterId)
        self.content = try container.decode(String.self, forKey: .content)
        self.senderId = try container.decode(Int64.self, forKey: .senderId)
        self.senderName = try container.decode(String.self, forKey: .senderName)
        self.receiverId = try container.decode(Int64.self, forKey: .receiverId)
        self.receiverName = try container.decode(String.self, forKey: .receiverName)
        self.photoURL = try container.decode(String.self, forKey: .photoURL)
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
//            print(formattedDate)  출력 예: "2024⋅12⋅22⋅일요일"
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
   "result": {
     "letter_id": 0,
     "content": "string",
     "sender_id": 0,
     "sender_name": "string",
     "receiver_id": 0,
     "receiver_name": "string",
     "created_at": "2024-12-22T08:15:28.182Z",
     "font": 0,
     "photo_url": "string"
   }
 }
 */
