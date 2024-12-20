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
        
        loginView.checkNicknameLabel.isHidden = true
        setAction()
    }
    
    private func setAction(){
        loginView.idTextField.addTarget(self, action: #selector(editingChangedIdTextField), for: .editingChanged)
        loginView.checkIdButton.addTarget(self, action: #selector(touchUpInsideCheckIdButton), for: .touchUpInside)
        
        loginView.createCodeButton.addTarget(self, action: #selector(touchUpInsideCreateCodeButton), for: .touchUpInside)
        loginView.loginButton.addTarget(self, action: #selector(touchUpInsideLoginButton), for: .touchUpInside)
    }
    
    @objc   // 닉네임 텍스트 라벨 편집 중 중복 확인 버튼 활성화 유무
    private func editingChangedIdTextField(){
        let isNullNickname = loginView.idTextField.text == ""
        loginView.checkIdButton.isUserInteractionEnabled = !isNullNickname
        loginView.checkIdButton.backgroundColor = isNullNickname ? .systemGray4 : .blismBlue
    }
    
    private func setLoginButton(){
        let checkLabel = loginView.checkNicknameLabel
        let loginButton = loginView.loginButton
        let checkCode = loginView.passwordTextField
        
        if checkLabel.text != "이미 존재하는 닉네임입니다." && checkCode.text != "" {
            loginButton.isUserInteractionEnabled = true
            loginButton.backgroundColor = .blismBlue
        } else {
            loginButton.isUserInteractionEnabled = false
            loginButton.backgroundColor = .systemGray4
        }
        
    }
    
    @objc   // 중복 확인 버튼 toupchUp
    private func touchUpInsideCheckIdButton(){
        let nickname = loginView.idTextField.text
        let checkLabel = loginView.checkNicknameLabel
        
        if nickname == "a" { // Ex) 중복
            checkLabel.text = "이미 존재하는 닉네임입니다."
            checkLabel.textColor = .errorRed
        } else {
            checkLabel.text = "사용 가능한 아아디입니다."
            checkLabel.textColor = .blismBlue
            loginView.createCodeButton.isUserInteractionEnabled = true
            loginView.createCodeButton.backgroundColor = .blismBlue
        }
        
        setLoginButton()
        loginView.checkNicknameLabel.isHidden = false
        
        // 중복 확인 API 연결
        // 중복이 아닐 때 - '사용 가능 아이디 입니다', loginButton 활성화, checkNicknameLabel Hidden-false
        // 중복일 때 - '이미 존재하는 닉네임입니다.', loginButton 활성화, checkNicknameLabel Hidden-false
    }
    
    @objc   // 확인 코드 생성 버튼
    private func touchUpInsideCreateCodeButton(){
        loginView.passwordTextField.font = .customFont(font: .PretendardMedium, ofSize: 15)
        let checkCode = String(Int.random(in: 1000 ... 9999))
        loginView.passwordTextField.text = checkCode
        
        setLoginButton()
    }
    
    @objc   // 로그인 버튼
    private func touchUpInsideLoginButton(){
        if let nickname = loginView.idTextField.text, let checkCode = loginView.passwordTextField.text {
            let signUpRequest = MemberSignUpRequest(nickname: nickname, password: checkCode)
            
            MemberAPI.shared.postSignUp(request: signUpRequest) {[weak self] response in
                if response.isSuccess {
                    if let data = response.data {
                        self?.saveInfo(memberId: data.memberId, nickname: nickname, checkCode: checkCode)
                    } else {
                        print("fetchSignUp: data nil")
                    }
                    
                } else {
                    print(response.message)
                }
            }
        } else {
            print("아이디, 비밀번호 입력 필요")
        }

//        let provider = MoyaProvider<MemberTargrtType>()
//        
//        guard let nickname = loginView.idTextField.text else {return }
//        guard let checkCode = loginView.passwordTextField.text else {return}
//        
//        let signUpRequest = MemberSignUpRequest(nickname: nickname, password: checkCode)
//        provider.request(.signUp(signUpRequest)) {[weak self] response in
//            switch response {
//            case let .success(result):
//                do {
//                    let decodingResult = try result.map(MemberSignUpResponse.self)
//                    if 200..<400 ~= decodingResult.code {
//                        self?.saveInfo(memberId: decodingResult.data.memberId, nickname: nickname, checkCode: checkCode)
//                        self?.presentTabBarVC()
//                    } else {
//                        print("서버 오류")
//                        print(decodingResult.message)
//                    }
//                } catch {
//                    print("디코딩 에러")
//                }     
//            case let .failure(error):
//                print(error.localizedDescription)
//            }
//        }
    }
    
    private func saveInfo(memberId: Int64, nickname: String, checkCode: String){
        KeychainService.shared.save(account: .userInfo, service: .memberId, value: "\(memberId)")
        KeychainService.shared.save(account: .userInfo, service: .nickname, value: nickname)
        KeychainService.shared.save(account: .userInfo, service: .checkCode, value: checkCode)
        
        KeychainService.shared.load(account: .userInfo, service: .checkCode)
        
        print("키 체인 저장 완료: \(KeychainService.shared.load(account: .userInfo, service: .checkCode) ?? "") ")
        print("키 체인 저장 완료: \(KeychainService.shared.load(account: .userInfo, service: .memberId) ?? "")")
        print("키 체인 저장 완료: \(KeychainService.shared.load(account: .userInfo, service: .nickname) ?? "")")
        
        
        DispatchQueue.main.async { [weak self] in
            self?.presentTabBarVC()
        }
        
    }
    
    private func presentTabBarVC(){
        let nextVC = TabBarController()
        nextVC.modalPresentationStyle = .fullScreen
        present(nextVC,animated: true)
    }
}


