//
//  LetterRequest.swift
//  Blism
//
//  Created by 이재혁 on 12/21/24.
//

import Foundation
import Moya
import UIKit

class LetterRequest {
    static let shared = LetterRequest()
    private init() {}
    
    let provider =  MoyaProvider<LetterTargetType>()
    
    // MARK: - write Letter
    func writeLetter(image: UIImage, request: WriteLetterRequest, completion: @escaping (Result<WriteLetterResponse, NetworkError>) -> Void) {
        provider.request(.writeLetter(image: image, request)) { response in
            switch response {
            case let .success(result):
                if 200..<400 ~= result.statusCode {
                    do {
                        let decodingResult = try JSONDecoder().decode(WriteLetterResponse.self, from: result.data)
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
    
    // MARK: - readLetter
    func readLetter(request: ReadLetterRequest, completion: @escaping(Result<ReadLetterResponse, NetworkError>) -> Void) {
        provider.request(.readLetter(request)) { response in
            switch response {
            case let .success(result):
                if 200..<400 ~= result.statusCode {
                    do {
                        let decodingResult = try JSONDecoder().decode(ReadLetterResponse.self, from: result.data)
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
    
    // MARK: - fetch sent letters
    func fetchSentLetters(request: FetchSentLettersRequest, completion: @escaping (Result<FetchSentLettersResponse, NetworkError>) -> Void) {
        provider.request(.fetchSentLetters(request)) { response in
            switch response {
            case let .success(result):
                if 200..<400 ~= result.statusCode {
                    do {
                        let decodingResult = try JSONDecoder().decode(FetchSentLettersResponse.self, from: result.data)
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
    
    // MARK: - fetch received letters
    func fetchReceivedLetters(request: FetchReceivedLettersRequest, completion: @escaping(Result<FetchReceivedLettersResponse, NetworkError>) -> Void) {
        provider.request(.fetchReceivedLetters(request)) { response in
            switch response {
            case let .success(result):
                if 200..<400 ~= result.statusCode {
                    do {
                        let decodingResult = try JSONDecoder().decode(FetchReceivedLettersResponse.self, from: result.data)
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
    
    // MARK: - edit letter
    func editWrittenLetter(letterId: String, image: UIImage, request: EditLetterRequest, completion: @escaping (Result<EditLetterResponse, NetworkError>) -> Void) {
        provider.request(.editLetter(image: image, request, letterId: letterId)) { response in
            switch response {
            case let .success(result):
                if 200..<400 ~= result.statusCode {
                    do {
                        let decodingResult = try JSONDecoder().decode(EditLetterResponse.self, from: result.data)
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
