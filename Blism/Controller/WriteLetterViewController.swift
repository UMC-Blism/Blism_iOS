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
        self.navigationItem.titleView = NavigationTitleView(title: "편지 작성하기", titleColor: .blismBlack)
        
        setAction()
    }
    
    private func setAction() {
        writeView.sendButton.addTarget(self, action: #selector(touchUpInsideSendButton), for: .touchUpInside)
    }
    
    @objc
    private func touchUpInsideSendButton() {
        let nextVC = SelectDoorDesignViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
