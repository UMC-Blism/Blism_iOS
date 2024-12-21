//
//  VisitorCheckViewController.swift
//  Blism
//
//  Created by 이수현 on 12/19/24.
//

import UIKit
class VisitorCheckViewController : UIViewController {
    private let visitorCheckView : VisitorCheckView
    private let onwerNickname: String
    
    init(onwerNickname: String) {
        self.onwerNickname = onwerNickname
        self.visitorCheckView = VisitorCheckView(onwerNickname: onwerNickname)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = visitorCheckView
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
        // 방문하기 버튼 액션
        visitorCheckView.visitButton.addTarget(self, action: #selector(touchUpVisiteButton), for: .touchUpInside)
        
        // 확인 코드 변경 될 때 액션
        visitorCheckView.checkCodeTextField.addTarget(self, action: #selector(editingChangedCheckCodeTextField), for: .editingChanged)
    }
    
    @objc   // 방문하기 액션
    func touchUpVisiteButton(){
        guard let inputCheckCode = visitorCheckView.checkCodeTextField.text else {return}
        let request = VisitorAuthRequest(nickname: onwerNickname, checkCode: inputCheckCode)
        
        MemberAPI.shared.authVisitor(request: request) {[weak self] result in
            switch result {
            case .success(let data):
                if data.isSuccess{
                    if let dataResult = data.result {   // 확인코드가 맞으면 -> 화면 이동
                        let nextVC = VisiterHomeViewController(mailBoxId: dataResult.mailBoxId)
                        self?.navigationController?.pushViewController(nextVC, animated: true)
                    } else {    // 확인 코드가 틀리면 -> 알림
                        self?.showWrongPasswordAlert()
                    }
                }
            case .failure(let error):
                let alert = NetworkAlert.shared.getAlertController(title: error.description)
                self?.present(alert, animated: true)
            }
        }

    }
    
    @objc   // 확인 코드 변경 될 때 액션
    func editingChangedCheckCodeTextField(){
        let isNull = visitorCheckView.checkCodeTextField.text == ""
        visitorCheckView.visitButton.isUserInteractionEnabled = !isNull
        visitorCheckView.visitButton.backgroundColor = isNull ? .systemGray4 : .blismBlue
    }
    
    private func showWrongPasswordAlert(){
        let alertVC = UIAlertController(title: "오류", message: "비밀번호를 다시 확인해주세요.", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "확인", style: .default)
        alertVC.addAction(alertAction)
        self.present(alertVC, animated: true)
    }
}
