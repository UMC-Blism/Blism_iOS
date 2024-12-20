//
//  ViewController.swift
//  Blism
//
//  Created by 이수현 on 12/16/24.
//

import UIKit

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
        
    }
    
    @objc
    private func touchUpInsideLoginButton(){
        let nextVC = HomeViewController()
        
        guard let id = loginView.idTextField.text else {return}
        guard let checkCode = loginView.passwordTextField.text else {return}
        
        KeychainService.shared.save(account: .userInfo, service: .id, value: id)
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}


