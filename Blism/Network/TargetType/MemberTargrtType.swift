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
    case checkId(MemberNicknameCheckRequest)
    case changeId(MemberChangeNicknameRequest)
    case searchNickcname
}

extension MemberTargrtType: TargetType {
    public var baseURL: URL {
        guard let baseURL = URL(string: "http://3.38.95.210:8080") else {
            // NetworkError.urlError
           fatalError("Error: Invalid URL")
       }
       return baseURL
    }
    
    public var path: String {
        switch self {
        case .signUp:
            return "/members/signup"
        case .checkId:
            return "/members/{nickname}"
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
        case .checkId:
            return .get
        case .changeId:
            return .patch
        case .searchNickcname:
            return .get
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .signUp(let request):
            return .requestJSONEncodable(request)
        case .checkId(let nickname):
            return .requestParameters(parameters: ["nickname": nickname.nickname], encoding: URLEncoding.queryString)
        case .changeId(let request):
            return .requestJSONEncodable(request)
        case .searchNickcname:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
