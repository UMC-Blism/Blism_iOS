//
//  VisibilityPermission.swift
//  Blism
//
//  Created by 송재곤 on 12/22/24.
//

import Foundation


public struct VisibilityPermissionRequest: Codable {
    let mailboxId: Int64
    let visibility: Int
    
    enum CodingKeys: CodingKey {
        case mailboxId
        case visibility
    }
}

/*
 {
   "memberId": 1
 }
 */


public struct VisibilityPermissionResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: String
    
    enum CodingKeys: String, CodingKey {
        case isSuccess
        case code
        case message
        case result
    }
}
