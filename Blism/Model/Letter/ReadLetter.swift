//
//  ReadLetter.swift
//  Blism
//
//  Created by 이재혁 on 12/21/24.
//

import Foundation

// MARK: - ReadLetter Request
public struct ReadLetterRequest: Codable {
    let letterId: Int64
}

// MARK: - ReadLetter Response
struct ReadLetterResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: ReadLetterResponseData
}

// MARK: - Letter Data (ReadLetter)
struct ReadLetterResponseData: Codable {
    let letterId: Int64
    let senderId: Int64
    let receiverId: Int64
    let mailBoxId: Int64
    let senderNickname: String
    let receiverNickname: String
    let content: String
    let photoUrl: String
    let font: Int
    let doorDesign: Int
    let colorDesign: Int
    let decorationDesign: Int
    let visibility: Int
    let createdAt: String?
    
    enum CodingKeys: CodingKey {
        case letterId
        case senderId
        case receiverId
        case mailBoxId
        case senderNickname
        case receiverNickname
        case content
        case photoUrl
        case font
        case doorDesign
        case decorationDesign
        case colorDesign
        case visibility
        case createdAt
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.letterId = try container.decode(Int64.self, forKey: .letterId)
        self.senderId = try container.decode(Int64.self, forKey: .senderId)
        self.receiverId = try container.decode(Int64.self, forKey: .receiverId)
        self.mailBoxId = try container.decode(Int64.self, forKey: .mailBoxId)
        self.senderNickname = try container.decode(String.self, forKey: .senderNickname)
        self.receiverNickname = try container.decode(String.self, forKey: .receiverNickname)
        self.content = try container.decode(String.self, forKey: .content)
        self.photoUrl = try container.decode(String.self, forKey: .photoUrl)
        self.font = try container.decode(Int.self, forKey: .font)
        self.doorDesign = try container.decode(Int.self, forKey: .doorDesign)
        self.decorationDesign = try container.decode(Int.self, forKey: .decorationDesign)
        self.colorDesign = try container.decode(Int.self, forKey: .colorDesign)
        self.visibility = try container.decode(Int.self, forKey: .visibility)
        let dateString = try container.decodeIfPresent(String.self, forKey: .createdAt)
        guard let dateString = dateString else {
            self.createdAt = "날짜 변환 실패"
            return
        }
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
            self.createdAt = formattedDate
            print(formattedDate) // 출력 예: "2024⋅12⋅22⋅일요일"
        } else {
            self.createdAt = "날짜 변환 실패"
        }
    }
}

// 이따 연결용
//private func test() {
//    let request = ReadLetterRequest(letterId: Int64(2))
//    LetterRequest.shared.readLetter(request: request) {[weak self] result in
//        switch result {
//        case .success(let data):
//            print("성공: \(data)")
//        case .failure(let error):
//            let alert = NetworkAlert.shared.getAlertController(title: error.description)
//            self?.present(alert, animated: true)
//        }
//    }
//}
