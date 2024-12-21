//
//  MailboxAPI.swift
//  Blism
//
//  Created by 송재곤 on 12/21/24.
//


import UIKit
import Moya

class MailboxAPI {
    static let shared = MailboxAPI()
    private init() {}
    
    let provider = MoyaProvider<MailboxTargetType>()
    
    
    // 우체통 조회
    func mailboxCheck(request: MailboxCheckingRequest, completion: @escaping (Result<MailboxCheckingResponse, NetworkError>) -> Void){
        provider.request(.getAllPastMail) { response in
            switch response {
            case let .success(result):
                do {
                    let decodingResult = try JSONDecoder().decode(MailboxCheckingResponse.self, from: result.data)
                    if 200..<400 ~= decodingResult.code{
                        completion(.success(decodingResult))
                    } else {
                        print("서버 오류")
                        print(decodingResult.message)
                        completion(.failure(.serverError(decodingResult.code)))
                    }
                } catch {
                    print("디코딩 에러")
                    completion(.failure(.failToDecode(error.localizedDescription)))
                }
            case let .failure(error):
                print("네트워크 오류")
                switch error {
                case .encodableMapping(let error):  // 인코딩 실패
                    completion(.failure(.encodingError(error.localizedDescription)))
                case .requestMapping(let message):    // 요청 실패
                    completion(.failure(.requestFailed(message)))
                case .parameterEncoding(let error):
                    completion(.failure(.parameterEncodingError(error.localizedDescription)))
                default:
                    completion(.failure(.otherMoyaError(error.errorDescription)))
                }
            }
        }
    }
}
