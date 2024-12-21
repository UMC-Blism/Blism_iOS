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
        provider.request(.getMyMailBoxInfo(request)) { response in
            switch response {
            case let .success(result):
                do {
                    if let jsonString = String(data: result.data, encoding: .utf8) {
                            print("서버 응답 데이터: \(jsonString)")
                        }
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
    
    // 과거 우체통 조회
    func pastMailboxCheck(request: PastMailboxCheckingRequest, completion: @escaping (Result<PastMailboxCheckingResponse, NetworkError>) -> Void){
        provider.request(.getAllPastMail(request)) { response in
            switch response {
            case let .success(result):
                do {
                    if let jsonString = String(data: result.data, encoding: .utf8) {
                            print("서버 응답 데이터: \(jsonString)")
                        }
                    let decodingResult = try JSONDecoder().decode(PastMailboxCheckingResponse.self, from: result.data)
                    if 200..<400 ~= decodingResult.code{
                        completion(.success(decodingResult))
                    } else {
                        print("서버 오류")
                        print(decodingResult.message)
                        completion(.failure(.serverError(decodingResult.code)))
                    }
                } catch {
                    print("디코딩 에러")
                    print(response)
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
    
    // 특정년도 우체통 조회
    func specificPastMailboxCheck(request: SpecificPastMailboxCheckingRequest, completion: @escaping (Result<SpecificPastMailboxCheckingResponse, NetworkError>) -> Void){
        provider.request(.getSpecificYearPastMail(request)) { response in
            switch response {
            case let .success(result):
                do {
                    if let jsonString = String(data: result.data, encoding: .utf8) {
                            print("서버 응답 데이터: \(jsonString)")
                        }
                    let decodingResult = try JSONDecoder().decode(SpecificPastMailboxCheckingResponse.self, from: result.data)
                    if 200..<400 ~= decodingResult.code{
                        completion(.success(decodingResult))
                    } else {
                        print("서버 오류")
                        print(decodingResult.message)
                        completion(.failure(.serverError(decodingResult.code)))
                    }
                } catch {
                    print("디코딩 에러")
                    print(response)
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
    
    // 우편함 열람 권한
    func VisibilityPermission(request: VisibilityPermissionRequest, completion: @escaping (Result<VisibilityPermissionResponse, NetworkError>) -> Void){
        provider.request(.patchvVisibilityPermission(request)) { response in
            switch response {
            case let .success(result):
                do {
                    if let jsonString = String(data: result.data, encoding: .utf8) {
                            print("서버 응답 데이터: \(jsonString)")
                        }
                    let decodingResult = try JSONDecoder().decode(VisibilityPermissionResponse.self, from: result.data)
                    if 200..<400 ~= decodingResult.code{
                        completion(.success(decodingResult))
                    } else {
                        print("서버 오류")
                        print(decodingResult.message)
                        completion(.failure(.serverError(decodingResult.code)))
                    }
                } catch {
                    print("디코딩 에러")
                    print(response)
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
