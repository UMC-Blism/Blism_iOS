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
    case searchNickcname(MemberSearchRequest)
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
        case .checkId(let request):
            return .requestParameters(parameters: ["nickname": request.nickname], encoding: URLEncoding.queryString)
        case .changeId(let request):
            return.requestParameters(parameters: ["original_nickname": request.originalNickname, "new_nickname" : request.newNickname], encoding: URLEncoding.queryString)
        case .searchNickcname(let request):
            return .requestParameters(parameters: ["nickname": request.nickname], encoding: URLEncoding.queryString)
        }
    }
    
    public var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
