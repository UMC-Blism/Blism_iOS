//
//  HomeMailBoxRequest.swift
//  Blism
//
//  Created by 송재곤 on 12/20/24.
//
import Moya

class HomeMailBoxRequest {
    private let provider = MoyaProvider<MailboxTargetType>()
    
    // API 요청 메서드
    func fetchMyMailBoxInfo(userId: Int, completion: @escaping (MailBoxResponse) -> Void) {
        provider.request(.getMyMailBoxInfo(userId: userId)) { result in
            switch result {
            case .success(let response):
                print("Request URL: \(response.request?.url?.absoluteString ?? "No URL")")
                do {
                    // 응답을 모델로 변환
                    let myMailBoxInfoResponse = try response.map(MailBoxResponse.self)
                    completion(myMailBoxInfoResponse)
                } catch {
                    // 변환 실패 시 오류 처리
                    print("Mapping error: \(error.localizedDescription)")
                }
            case .failure(let error):
                print("Network request error: \(error.localizedDescription)")
            }
        }
    }
}
