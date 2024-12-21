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
    case getAllPastMail(PastMailboxCheckingRequest)
    case getSpecificYearPastMail(SpecificPastMailboxCheckingRequest)
    case patchvVisibilityPermission(VisibilityPermissionRequest)
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
        case .getMyMailBoxInfo:
            return "/mailboxes"
        case .getAllPastMail:
            return "/mailboxes/past"
        case .getSpecificYearPastMail(let request):
            // `memberId`와 `year`를 동적으로 포함시킴
            return "/mailboxes/past/\(request.memberId)"
        case .patchvVisibilityPermission:
            return "/mailboxes/visibility"
        }}
    
    var method: Moya.Method {
        switch self {
        case .getMyMailBoxInfo:
            return .get
        case .getAllPastMail:
            return .get
        case .getSpecificYearPastMail:
            return .get
        case .patchvVisibilityPermission:
            return .patch
        }
    }
    
    var task: Moya.Task { // 파라미터 확인
        switch self {
        case .getMyMailBoxInfo(let request):
            return .requestParameters(parameters: ["memberId": request.memberId], encoding: URLEncoding.queryString)
        case .getAllPastMail(let request):
            return .requestParameters(parameters: ["memberId": request.memberId], encoding: URLEncoding.queryString)
        case .getSpecificYearPastMail(let request):
            return .requestParameters(parameters: ["year": request.year], encoding: URLEncoding.queryString)
        case .patchvVisibilityPermission(let request):
            return .requestJSONEncodable(request)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type" : "application/json"]
        
        
    }
}
