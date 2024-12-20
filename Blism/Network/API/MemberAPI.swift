//
//  MemberAPI.swift
//  Blism
//
//  Created by 이수현 on 12/20/24.
//

import UIKit
import Moya

class MemberAPI {
    static let shared = MemberAPI()
    private init() {}
    
    let provider = MoyaProvider<MemberTargrtType>()
    
    func postSignUp(request: MemberSignUpRequest, completion: @escaping (MemberSignUpResponse) -> Void){
        provider.request(.signUp(request)) { response in
            switch response {
            case let .success(result):
                do {
                    let decodingResult = try JSONDecoder().decode(MemberSignUpResponse.self, from: result.data)
                    if 200..<400 ~= decodingResult.code{
                        completion(decodingResult)
                    } else {
                        print("서버 오류")
                        print(decodingResult.message)
                    }
                } catch {
                    print("디코딩 에러")
                }
            case let .failure(error):
                print("네트워크 오류")
                print(error.localizedDescription)
            }
        }
    }
    
    func getCheckNickname() {}
}
