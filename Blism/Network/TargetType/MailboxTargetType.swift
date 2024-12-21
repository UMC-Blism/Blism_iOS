//
//  SampleNetwork.swift
//  Blism
//
//  Created by 이수현 on 12/16/24.
//

import Foundation
import Moya

enum MailboxTargetType {
    case getMyMailBoxInfo(userId: Int)
    case getAllPastMail(userId: Int)
    case getSpecificYearPastMail(userId: Int, year: Int)
    case getOtherPersonMailbox(userId: Int, nickname: String)
}

extension MailboxTargetType: TargetType {
    var baseURL: URL { //url 수정
        guard let baseURL = URL(string: "http://3.38.95.210:8080/swagger-ui/index.html#") else {
            fatalError("Error: Invalid URL")
        }
        
        return baseURL
    }
    
    var path: String {
        switch self {
        case .getMyMailBoxInfo(_):
            return "/mailboxes"
        case .getAllPastMail(_):
            return "/mailboxes/past"
        case .getSpecificYearPastMail(_, let year):
            return "/mailboxes/\(year)"
        case .getOtherPersonMailbox(_,let nickname):
            return "/mailboxes/\(nickname)"
        }}
    
    var method: Moya.Method {
        switch self {
        case .getMyMailBoxInfo(_):
            return .get
        case .getAllPastMail(_):
            return .get
        case .getSpecificYearPastMail(_, _):
            return .get
        case .getOtherPersonMailbox(_, _):
            return .get
            
        }
    }
    
    var task: Moya.Task { // 파라미터 확인
        switch self {
        case .getMyMailBoxInfo(let userId):
            return .requestParameters(parameters: ["memberId" : userId], encoding: URLEncoding.queryString)
        case .getAllPastMail(let userId):
            return .requestParameters(parameters: ["memeberId" : userId], encoding: URLEncoding.queryString)
        case .getSpecificYearPastMail(_, _):
            return .requestParameters(parameters: [:], encoding: URLEncoding.queryString)
        case .getOtherPersonMailbox(let userId, let nickname):
            return .requestParameters(parameters: ["memeberId" : userId, "nickname" : nickname], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getMyMailBoxInfo(_):
            return ["Content-Type" : "application/json"]
        case .getAllPastMail(_):
            return ["Content-Type" : "application/json"]
        case .getSpecificYearPastMail(_, _):
            return ["Content-Type" : "application/json"]
        case .getOtherPersonMailbox(_, _):
            return ["Content-Type" : "application/json"]
            
        }
        
        
    }
}
