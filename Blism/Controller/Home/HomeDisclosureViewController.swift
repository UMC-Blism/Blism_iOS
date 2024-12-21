//
//  HomeDateAlertViewController.swift
//  Blism
//
//  Created by 송재곤 on 12/19/24.
//

import UIKit

class HomeDisclosureViewController: UIViewController {
    private let rootView = HomeDisclosureView()
    //API 연결
    var permissionResponse : VisibilityPermissionResponse?

    override func viewDidLoad() {
        super.viewDidLoad()
        view = rootView
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5) //투명도 50
        
        tapGesture()
        
        textSetting()
        
    }
    
    func textSetting(){
        let updatedText = rootView.alertTitle.text

        let attributedText = NSMutableAttributedString(string: updatedText ?? "")

        // 특정 텍스트 범위를 찾고 속성 적용
        if let range = updatedText?.range(of: "우체통") {
            let nsRange = NSRange(range, in: updatedText!)
            
            // 텍스트 색상 적용
            attributedText.addAttribute(.foregroundColor, value: UIColor.blue1 ?? UIColor.blue, range: nsRange)
            
            attributedText.addAttribute(.font, value: UIFont.systemFont(ofSize: 16, weight: .semibold), range: nsRange) // 굵기 설정
        }

        // 결과적으로 attributedText를 UILabel에 설정
        rootView.alertTitle.attributedText = attributedText
    }
    func tapGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(goBackToHome))
        self.view.addGestureRecognizer(tapGesture)
        
        rootView.yesButton.addTarget(self, action: #selector(yesButtonTapped), for: .touchUpInside)
        rootView.noButton.addTarget(self, action: #selector(noButtonTapped), for: .touchUpInside)
    }
    @objc func goBackToHome(){
        view.backgroundColor = UIColor.black.withAlphaComponent(0) //투명도 100
        dismiss(animated: true, completion: nil)
    }
    
    @objc func yesButtonTapped(){
        KeychainService.shared.save(account: .userInfo, service: .visibilityPermission, value: "1")
        if let userId = KeychainService.shared.load(account: .userInfo, service: .memberId){
            visiblePermission(userId: userId, visibility: 1)
        }else {
            print("userId를 가져오는데 실패하였습니다")
        }
        dismiss(animated: true, completion: nil)
        
    }
    @objc func noButtonTapped(){
        KeychainService.shared.save(account: .userInfo, service: .visibilityPermission, value: "0")
        if let userId = KeychainService.shared.load(account: .userInfo, service: .memberId){
            visiblePermission(userId: userId, visibility: 0)
        }else {
            print("userId를 가져오는데 실패하였습니다")
        }
        dismiss(animated: true, completion: nil)
    }
    // API 호출 함수
    private func visiblePermission(userId: String, visibility: Int) {
        guard let mailboxId = Int64(userId) else {return}
        
        let request = VisibilityPermissionRequest(mailboxId: mailboxId, visibility: visibility)
        MailboxAPI.shared.VisibilityPermission(request: request) {[weak self] result in
            switch result {
            case .success(let data):
                print("\(data)**")
                if data.isSuccess {
                    self?.permissionResponse = data
                } else {
                    print("data isFailed")
                }
                
            case .failure(let error):
                let alert = NetworkAlert.shared.getAlertController(title: error.description)
                self?.present(alert, animated: true)
            }
        }
    }
}
