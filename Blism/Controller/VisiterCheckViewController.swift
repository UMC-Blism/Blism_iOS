//
//  VisiterCheckViewController.swift
//  Blism
//
//  Created by 이수현 on 12/19/24.
//

import UIKit
class VisiterCheckViewController : UIViewController {
    private let visiterCheckView = VisiterCheckView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = visiterCheckView
        setNavigationBar()
        setAction()
    }
    
    private func setNavigationBar(){
        // 뒤로 가기 버튼
        let leftBarButton = UIBarButtonItem(image: .popIcon, style: .plain, target: self, action: #selector(popAction))
        leftBarButton.tintColor = .blismBlack
        self.navigationItem.setLeftBarButton(leftBarButton, animated: true)
        
        // 타이틀
        self.navigationItem.titleView = NavigationTitleView(title: "확인 코드 인증", titleColor: .blismBlack)
    }
    
    @objc
    private func popAction(){
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setAction(){
        visiterCheckView.visitButton.addTarget(self, action: #selector(touchUpVisiteButton), for: .touchUpInside)
    }
    
    @objc
    func touchUpVisiteButton(){
        let nextVC = VisiterHomeViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
