//
//  CheckNicknameViewController.swift
//  Blism
//
//  Created by 이수현 on 12/19/24.
//

import UIKit

class CheckNicknameViewController : UIViewController {
    private let changeNicknameView = CheckNicknameView()
    private var inputNickname = ""
    private var inputCheckCode = ""
    
    override func viewDidLoad() {
        changeNicknameView.nicknameGroupView.errMessageLabel.isHidden = true
        changeNicknameView.checkCodeGroupView.errMessageLabel.isHidden = true
        
        self.view = changeNicknameView

        addAction()
        setNavigationBar()
    }
    
    private func addAction(){
        changeNicknameView.nextButton.addTarget(self, action: #selector(touchUpNextButton), for: .touchUpInside)
        
        changeNicknameView.nicknameGroupView.textField.addTarget(self, action: #selector(editingDidEndTextField), for: .editingChanged)
        
        changeNicknameView.checkCodeGroupView.textField.addTarget(self, action: #selector(editingDidEndTextField), for: .editingChanged)
    }
    
    @objc
    func editingDidEndTextField(){
        let isValid = changeNicknameView.nicknameGroupView.textField.text != "" && changeNicknameView.checkCodeGroupView.textField.text != ""
        
        changeNicknameView.nextButton.isUserInteractionEnabled = isValid
        changeNicknameView.nextButton.backgroundColor = isValid ? .blismBlue : .systemGray4
        
        inputNickname = changeNicknameView.nicknameGroupView.textField.text ?? ""
        inputCheckCode = changeNicknameView.checkCodeGroupView.textField.text ?? ""
    }
    
    @objc // 다음 버튼
    func touchUpNextButton(){
        guard let savedNickname = KeychainService.shared.load(account: .userInfo, service: .nickname) else {
            print("CheckNicknameViewController - touchUpNextButton - nickname 불러오기 실패")
            return
        }
        
        guard let savedCheckCode = KeychainService.shared.load(account: .userInfo, service: .checkCode) else {
            print("CheckNicknameViewController - touchUpNextButton - myCode 불러오기 실패")
            return
        }
        
        print("savedNickname: \(savedNickname)")
        print("savedCheckCode: \(savedCheckCode)")
        print("inputNickname: \(inputNickname)")
        print("inputCheckCode: \(inputCheckCode)")
        
        changeNicknameView.nicknameGroupView.errMessageLabel.isHidden = inputNickname == savedNickname
        changeNicknameView.checkCodeGroupView.errMessageLabel.isHidden = inputCheckCode == savedCheckCode
        
        if inputNickname == savedNickname && inputCheckCode == savedCheckCode {
            let nextVC = ChangeNicknameViewController()
            self.navigationController?.pushViewController(nextVC, animated: true)
        }

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
