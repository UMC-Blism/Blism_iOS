//
//  SampleNetwork.swift
//  Blism
//
//  Created by 이수현 on 12/16/24.
//

import Foundation
import Moya

enum MailboxTargetType {
    case getMyMailBoxInfo(MailboxCheckingRequest)
    case getAllPastMail
    case getSpecificYearPastMail(userId: Int, year: Int)
}

extension MailboxTargetType: TargetType {
    var baseURL: URL { //url 수정
        guard let baseURL = URL(string: "http://3.38.95.210:8080") else {
            fatalError("Error: Invalid URL")
        }
        
        return baseURL
    }
    
    var path: String {
        switch self {
        case .getMyMailBoxInfo(_):
            return "/mailboxes"
        case .getAllPastMail:
            return "/mailboxes/past"
        case .getSpecificYearPastMail(_, let year):
            return "/mailboxes/\(year)"
        }}
    
    var method: Moya.Method {
        switch self {
        case .getMyMailBoxInfo:
            return .get
        case .getAllPastMail:
            return .get
        case .getSpecificYearPastMail(_, _):
            return .get
            
        }
    }
    
    var task: Moya.Task { // 파라미터 확인
        switch self {
        case .getMyMailBoxInfo(let request):
            return .requestJSONEncodable(request)
        case .getAllPastMail:
            return .requestPlain
        case .getSpecificYearPastMail(_, _):
            return .requestParameters(parameters: [:], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type" : "application/json"]
        
        
    }
}
