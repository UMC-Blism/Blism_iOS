//
//  SpecificPastMailboxCheck.swift
//  Blism
//
//  Created by 송재곤 on 12/22/24.
//
import Foundation


public struct SpecificPastMailboxCheckingRequest: Codable {
    let memberId: Int64
    let year: String
    
    enum CodingKeys: CodingKey {
        case memberId
        case year
    }
}

/*
 {
   "memberId": 1
 }
 */


public struct SpecificPastMailboxCheckingResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: SpecificPastMailboxCheckingResponseData?
    
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
        self.result = try container.decodeIfPresent(SpecificPastMailboxCheckingResponseData.self, forKey: .result)
    }
    
}

public struct SpecificPastMailboxCheckingResponseData: Codable {
    let memberId: Int64
    let count: Int
    let visibility: Int?
    let letters: [specificPastMailBoxData]
    
    enum CodingKeys:  String, CodingKey {
        case memberId
        case count
        case visibility
        case letters
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.memberId = try container.decode(Int64.self, forKey: .memberId)
        self.count = try container.decode(Int.self, forKey: .count)
        self.visibility = try container.decodeIfPresent(Int.self, forKey: .visibility)
        self.letters = try container.decode([specificPastMailBoxData].self, forKey: .letters)
    }
}
/*
 {
    "memberId" = Int^4
    "count" = Int
    "visibility" = Bool
    "letters" = List
 }
 */

public struct specificPastMailBoxData: Codable {
    let letterId: Int64
    let doorImageUrl: String
    let visibility: Int
    
    enum CodingKeys:  String, CodingKey {
        case letterId = "id"
        case doorImageUrl
        case visibility
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.letterId = try container.decode(Int64.self, forKey: .letterId)
        self.doorImageUrl = try container.decode(String.self, forKey: .doorImageUrl)
        self.visibility = try container.decode(Int.self, forKey: .visibility)
    }
}

//{
//    "letterId": Int64,
//    "doorImageUrl": String
//    "visibility": Bool
//}
