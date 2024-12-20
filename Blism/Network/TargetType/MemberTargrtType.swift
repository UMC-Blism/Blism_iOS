//
//  MemberTargrtType.swift
//  Blism
//
//  Created by 이수현 on 12/20/24.
//

import Moya
import Foundation

public enum MemberTargrtType {
    case signUp(MemberSignUpRequest)
    case duplicateId
    case changeId
    case searchNickcname
}

extension MemberTargrtType: TargetType {
    public var baseURL: URL {
        guard let baseURL = URL(string: "https://3.38.95.210:8080/swagger-ui/index.html#") else {
           fatalError("Error: Invalid URL")
       }
       return baseURL
    }
    
    public var path: String {
        switch self {
        case .signUp:
            return "/members/signup"
        case .duplicateId:
            return "/members"
        case .changeId:
            return "/members/change"
        case .searchNickcname:
            return "/members/search"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .signUp:
            return .post
        case .duplicateId:
            return .get
        case .changeId:
            return .patch
        case .searchNickcname:
            return .get
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .signUp(let memberSignUpRequest):
            return .requestJSONEncodable(memberSignUpRequest)
        case .duplicateId:
             return .requestPlain
        case .changeId:
            return .requestPlain
        case .searchNickcname:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    
}
