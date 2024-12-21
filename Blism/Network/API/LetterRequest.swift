//
//  LetterRequest.swift
//  Blism
//
//  Created by 이재혁 on 12/21/24.
//

import Foundation
import Moya

class LetterRequest {
    private let provider =  MoyaProvider<LetterTargetType>()
    
    // readLetter
    func fetchLetter(letterID: Int64, completion: @escaping (Result<LetterData, Error>) -> Void) {
        provider.request(.readLetter(letterID: letterID)) { result in
            switch result {
            case .success(let response):
                do {
                    let decoder = JSONDecoder()
                    let readLetterResponse = try decoder.decode(ReadLetterResponse.self, from: response.data)
                    if readLetterResponse.isSuccess, let letterData = readLetterResponse.data {
                        completion(.success(letterData))
                    } else {
                        let errorMessage = readLetterResponse.message
                        completion(.failure(NSError(domain: "", code: readLetterResponse.code, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
                    }
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
