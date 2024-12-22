//
//  ReplyAPI.swift
//  Blism
//
//  Created by 이수현 on 12/22/24.
//

import UIKit
import Moya

class ReplyAPI {
    static let shared = ReplyAPI()
    private init() {}
    
    private let provider = MoyaProvider<ReplyTargetType>()
    
    // 받은 리스트 조회
    func getReceivedLetterList(request: ReadReceivedLetterListRequest, completion: @escaping (Result<ReadReceivedLetterListResponse, NetworkError>) -> Void){
        provider.request(.readAllReceivedReply(request)) { response in
            switch response {
            case let .success(result):
                if 200..<400 ~= result.statusCode {
                    do {
                        let decodingResult = try JSONDecoder().decode(ReadReceivedLetterListResponse.self, from: result.data)
                        if decodingResult.isSuccess {
                            completion(.success(decodingResult))
                        } else {
                            print("")
                            completion(.failure(.invalidResponse))
                        }
                    } catch {
                        print("디코딩 에러")
                        completion(.failure(.failToDecode(error.localizedDescription)))
                    }
                } else {
                    print("서버 오류")
                    completion(.failure(.serverError(result.statusCode)))
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
    
    // 보낸 리스트 조회
    func getSentLetterList(request: ReadSentLetterListRequest, completion: @escaping (Result<ReadSentLetterListResponse, NetworkError>) -> Void){
        provider.request(.readAllSentReply(request)) { response in
            switch response {
            case let .success(result):
                if 200..<400 ~= result.statusCode {
                    do {
                        let decodingResult = try JSONDecoder().decode(ReadSentLetterListResponse.self, from: result.data)
                        if decodingResult.isSuccess {
                            completion(.success(decodingResult))
                        } else {
                            print("")
                            completion(.failure(.invalidResponse))
                        }
                    } catch {
                        print("디코딩 에러")
                        completion(.failure(.failToDecode(error.localizedDescription)))
                    }
                } else {
                    print("서버 오류")
                    completion(.failure(.serverError(result.statusCode)))
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
