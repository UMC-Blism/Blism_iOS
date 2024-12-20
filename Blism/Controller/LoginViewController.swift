//
//  ViewController.swift
//  Blism
//
//  Created by 이수현 on 12/16/24.
//

import UIKit
import Moya

class LoginViewController: UIViewController {
    private let loginView = LoginView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = loginView
        setAction()
    }
    
    private func setAction(){
        loginView.checkIdButton.addTarget(self, action: #selector(touchUpInsideCheckIdButton), for: .touchUpInside)
        loginView.createCodeButton.addTarget(self, action: #selector(touchUpInsideCreateCodeButton), for: .touchUpInside)
        loginView.loginButton.addTarget(self, action: #selector(touchUpInsideLoginButton), for: .touchUpInside)
    }
    
    @objc
    private func touchUpInsideCheckIdButton(){
        
    }
    
    @objc
    private func touchUpInsideCreateCodeButton(){
        let checkCode = String(Int.random(in: 1000 ... 9999))
        loginView.passwordTextField.text = checkCode
    }
    
    @objc
    private func touchUpInsideLoginButton(){
        let provider = MoyaProvider<MemberTargrtType>()
        
        guard let nickname = loginView.idTextField.text else {return }
        guard let checkCode = loginView.passwordTextField.text else {return}
        
        let signUpRequest = MemberSignUpRequest(nickname: nickname, password: checkCode)
        provider.request(.signUp(signUpRequest)) {[weak self] response in
            switch response {
            case let .success(result):
                do {
                    let decodingResult = try result.map(MemberSignUpResponse.self)
                    if 200..<400 ~= decodingResult.code {
                        self?.saveInfo(memberId: decodingResult.data.memberId, nickname: nickname, checkCode: checkCode)
                        self?.presentTabBarVC()
                    } else {
                        print("서버 오류")
                        print(decodingResult.message)
                    }
                } catch {
                    print("디코딩 에러")
                }     
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func saveInfo(memberId: Int64, nickname: String, checkCode: String){
        KeychainService.shared.save(account: .userInfo, service: .memberId, value: "\(memberId)")
        KeychainService.shared.save(account: .userInfo, service: .nickname, value: nickname)
        KeychainService.shared.save(account: .userInfo, service: .checkCode, value: checkCode)
        
        KeychainService.shared.load(account: .userInfo, service: .checkCode)
        
        print("키 체인 저장 완료: \(KeychainService.shared.load(account: .userInfo, service: .checkCode) ?? "") ")
        print("키 체인 저장 완료: \(KeychainService.shared.load(account: .userInfo, service: .memberId) ?? "")")
        print("키 체인 저장 완료: \(KeychainService.shared.load(account: .userInfo, service: .nickname) ?? "")")
    }
    
    private func presentTabBarVC(){
        let nextVC = TabBarController()
        nextVC.selectedIndex = 1
        nextVC.modalPresentationStyle = .fullScreen
        present(nextVC,animated: true)
    }
}


