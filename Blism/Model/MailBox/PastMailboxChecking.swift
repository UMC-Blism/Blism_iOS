//
//  PastMailboxChecking.swift
//  Blism
//
//  Created by 송재곤 on 12/21/24.
//
import Foundation


public struct PastMailboxCheckingRequest: Codable {
    let memberId: Int64
    
    enum CodingKeys: CodingKey {
        case memberId
    }
}

/*
 {
   "memberId": 1
 }
 */


public struct PastMailboxCheckingResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: PastMailboxCheckingResponseData?
    
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
        self.result = try container.decodeIfPresent(PastMailboxCheckingResponseData.self, forKey: .result)
    }
    
}

public struct PastMailboxCheckingResponseData: Codable {
    let memberId: Int64
    let count: Int
    let pastMailboxList: [pastMailBoxData]
    
    enum CodingKeys:  String, CodingKey {
        case memberId
        case count
        case pastMailboxList
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.memberId = try container.decode(Int64.self, forKey: .memberId)
        self.count = try container.decode(Int.self, forKey: .count)
        self.pastMailboxList = try container.decode([pastMailBoxData].self, forKey: .pastMailboxList)
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

public struct pastMailBoxData: Codable {
    let pastMailboxId: Int64
    let year: String
    
    enum CodingKeys:  String, CodingKey {
        case pastMailboxId
        case year
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.pastMailboxId = try container.decode(Int64.self, forKey: .pastMailboxId)
        self.year = try container.decode(String.self, forKey: .year)
    }
}

//{
//    "letterId": Int64,
//    "doorImageUrl": String
//    "visibility": Bool
//}
