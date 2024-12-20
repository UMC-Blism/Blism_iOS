//
//  SampleNetwork.swift
//  Blism
//
//  Created by 이수현 on 12/16/24.
//

import Foundation
import Moya

enum MyMailBoxInfo {
    case getMyMailBoxInfo(userId: Int)
}

extension MyMailBoxInfo: TargetType {
    var baseURL: URL { //url 수정
        guard let baseURL = URL(string: "https://dummyjson.com") else {
            fatalError("Error: Invalid URL")
        }
        
        return baseURL
    }
    
    var path: String {
        switch self {
        case .getMyMailBoxInfo(_):
            return "/mailboxes"
        }}
    
    var method: Moya.Method {
        switch self {
        case .getMyMailBoxInfo(_):
            return .get
            
        }
    }
    
    var task: Moya.Task { //파라미터 확인
        switch self {
        case .getMyMailBoxInfo(let userId):
            return .requestParameters(parameters: ["q" : userId], encoding: URLEncoding.queryString)
        }
        
        
    }
    var headers: [String : String]? {
        switch self {
        case .getMyMailBoxInfo(_):
            return ["Content-Type" : "application/json"]
        }
        
        
    }
}
