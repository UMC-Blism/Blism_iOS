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
    
    // 회원가입
    func postSignUp(request: MemberSignUpRequest, completion: @escaping (Result<MemberSignUpResponse, NetworkError>) -> Void){
        provider.request(.signUp(request)) { response in
            switch response {
            case let .success(result):
                do {
                    let decodingResult = try JSONDecoder().decode(MemberSignUpResponse.self, from: result.data)
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
    
    // 닉네임 중복
    func getCheckNickname(request: MemberNicknameCheckRequest, completion: @escaping (Result<MemberNicknameCheckResponse, NetworkError>) -> Void) {
        provider.request(.checkId(request)) { response in
            switch response {
            case let .success(result):
                do {
                    print(result.statusCode)
                    let decodingResult = try JSONDecoder().decode(MemberNicknameCheckResponse.self, from: result.data)
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
    
    // 닉네임 변경
    func changeNickname(request: MemberChangeNicknameRequest, completion: @escaping (Result<MemberChangeNicknameReponse, NetworkError>) -> Void) {
        provider.request(.changeId(request)) { response in
            switch response {
            case let .success(result):
                print(result)
                do {
                    let decodingResult = try JSONDecoder().decode(MemberChangeNicknameReponse.self, from: result.data)
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
    
    // 닉네임 검색
    func searchNickname(request: MemberSearchRequest, completion: @escaping (Result<MemberSearchResponse, NetworkError>) -> Void) {
        provider.request(.searchNickcname(request)) { response in
            switch response {
            case let .success(result):
                print(result)
                do {
                    let decodingResult = try JSONDecoder().decode(MemberSearchResponse.self, from: result.data)
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
    
    // 방문자 인증
    func authVisitor(request: VisitorAuthRequest, completion: @escaping (Result<VisitorAuthResponse, NetworkError>) -> Void) {
        provider.request(.visitorAuth(request)) { response in
            switch response {
            case let .success(result):
                print(result)
                do {
                    let decodingResult = try JSONDecoder().decode(VisitorAuthResponse.self, from: result.data)
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
