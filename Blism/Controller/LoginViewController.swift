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
        loginView.loginButton.addTarget(self, action: #selector(touchUpInsideLoginButton), for: .touchUpInside)
    }
    
    @objc
    private func touchUpInsideLoginButton(){
        let nextVC = TabBarController()
        nextVC.selectedIndex = 1
        nextVC.modalPresentationStyle = .fullScreen
        present(nextVC,animated: true)
    }
}


