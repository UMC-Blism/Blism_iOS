//
//  CheckNicknameViewController.swift
//  Blism
//
//  Created by 이수현 on 12/19/24.
//

import UIKit

class CheckNicknameViewController : UIViewController {
    private let changeNicknameView = CheckNicknameView()
    
    override func viewDidLoad() {
        self.view = changeNicknameView
        addAction()
        setNavigationBar()
    }
    
    private func addAction(){
        changeNicknameView.nextButton.addTarget(self, action: #selector(touchUpNextButton), for: .touchUpInside)
    }
    
    @objc
    func touchUpNextButton(){
        let nextVC = ChangeNicknameViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    private func setNavigationBar(){
        // 뒤로 가기 버튼
        let leftBarButton = UIBarButtonItem(image: .popIcon, style: .plain, target: self, action: #selector(popAction))
        leftBarButton.tintColor = .blismBlack
        self.navigationItem.setLeftBarButton(leftBarButton, animated: true)
        
        // 타이틀
        self.navigationItem.titleView = NavigationTitleView(title: "닉네임 (아이디) 변경", titleColor: .blismBlack)
    }
    
    @objc
    private func popAction(){
        self.navigationController?.popViewController(animated: true)
    }
}
