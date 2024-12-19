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
    }
    
    private func addAction(){
        changeNicknameView.nextButton.addTarget(self, action: #selector(touchUpNextButton), for: .touchUpInside)
    }
    
    @objc
    func touchUpNextButton(){
        let nextVC = ChangeNicknameViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
