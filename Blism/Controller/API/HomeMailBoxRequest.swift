//
//  HomeMailBoxRequest.swift
//  Blism
//
//  Created by 송재곤 on 12/20/24.
//
import Moya

class HomeMailBoxRequest {
    private let provider = MoyaProvider<MyMailBoxInfo>()
      
      // API 요청 메서드
      func fetchMyMailBoxInfo(userId: Int, completion: @escaping (Result<MailBoxCollectionViewApiModel, Error>) -> Void) {
          provider.request(.getMyMailBoxInfo(userId: userId)) { result in
              switch result {
              case .success(let response):
                  do {
                      // 응답을 모델로 변환
                      let myMailBoxInfoResponse = try response.map(MailBoxCollectionViewApiModel.self)
                      completion(.success(myMailBoxInfoResponse))
                  } catch {
                      completion(.failure(error)) // 변환 실패 시 오류 처리
                  }
              case .failure(let error):
                  completion(.failure(error)) // 네트워크 오류 처리
              }
          }
      }
}
