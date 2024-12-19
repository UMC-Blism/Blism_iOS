//
//  WriteLetterViewController.swift
//  Blism
//
//  Created by 이재혁 on 12/18/24.
//

import UIKit

class WriteLetterViewController: UIViewController {

    private let writeView = WriteLetterView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = writeView
        
        setNavigationBar()
        setAction()
    }
    
    private func setAction() {
        writeView.sendButton.addTarget(self, action: #selector(touchUpInsideSendButton), for: .touchUpInside)
    }
    
    private func setNavigationBar(){
        // 뒤로 가기 버튼
        let leftBarButton = UIBarButtonItem(image: .popIcon, style: .plain, target: self, action: #selector(popAction))
        leftBarButton.tintColor = .blismBlack
        self.navigationItem.setLeftBarButton(leftBarButton, animated: true)
        
        self.navigationItem.titleView = NavigationTitleView(title: "편지 작성하기", titleColor: .blismBlack)
    }
    
    @objc
    private func popAction(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc
    private func touchUpInsideSendButton() {
        let nextVC = SelectDoorDesignViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
