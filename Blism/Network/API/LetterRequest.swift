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
        provider.request(.writeLetter(image: image, request)) { result in
            switch result {
            case let .success(response):
                print(result)
                do {
                    let decodingResult = try JSONDecoder().decode(WriteLetterResponse.self, from: response.data)
                    if 200..<400 ~= decodingResult.code {
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
    
    // readLetter
    func readLetter(request: ReadLetterRequest, completion: @escaping(Result<ReadLetterResponse, NetworkError>) -> Void) {
        provider.request(.readLetter(request)) { response in
            switch response {
            case let .success(result):
                print(result)
                print(response)
                do {
                    let decodingResult = try JSONDecoder().decode(ReadLetterResponse.self, from: result.data)
                    if 200..<400 ~= decodingResult.code {
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
