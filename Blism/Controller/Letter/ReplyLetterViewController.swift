//
//  ReplyLetterViewController.swift
//  Blism
//
//  Created by 송재곤 on 12/19/24.
//

import UIKit



class ReplyLetterViewController: UIViewController {
    
    private let rootView = WriteLetterView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = rootView
        setNavigationBar()
        
        setAction()
    }
    
    private func setAction() {
        rootView.sendButton.addTarget(self, action: #selector(touchUpInsideSendButton), for: .touchUpInside)
    }
    
    @objc
    private func touchUpInsideSendButton() {
        let nextVC = SelectDoorDesignViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    private func setNavigationBar(){
        // 뒤로 가기 버튼
        let leftBarButton = UIBarButtonItem(image: .popIcon, style: .plain, target: self, action: #selector(popAction))
        leftBarButton.tintColor = .blismBlack
        self.navigationItem.setLeftBarButton(leftBarButton, animated: true)
        
        // 타이틀
        self.navigationItem.titleView = NavigationTitleView(title: "답장하기", titleColor: .blismBlack)
    }
    
    @objc
    private func popAction(){
        dismiss(animated: true)
    }
}

