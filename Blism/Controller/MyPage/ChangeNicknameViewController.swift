//
//  ChangeNicknameViewController.swift
//  Blism
//
//  Created by 이수현 on 12/19/24.
//

import UIKit

class ChangeNicknameViewController: UIViewController{
    private let changeNicknameView = ChangeNicknameView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = changeNicknameView
        
        setNavigationBar()
        setAction()
    }
    

    
    private func setAction(){
        
        // 닉네임 텍스트필드 액션
        changeNicknameView.nicknameGroupView.textField.addTarget(self, action: #selector(editingChangedNickname), for: .editingChanged)
        
        // 중복 확인 버튼 액션
        changeNicknameView.checkIdButton.addTarget(self, action: #selector(touchUpInsideCheckIdButton), for: .touchUpInside)
        
        // 닉네임 재입력 액션
        changeNicknameView.reInputnicknameGroupView.textField.addTarget(self, action: #selector(editingChangedReInput), for: .editingChanged)
        
        // 닉네임 변경 버튼 액션
        changeNicknameView.nextButton.addTarget(self, action: #selector(touchUpInsideNextButton), for: .touchUpInside)
    }
    
    @objc // 닉네임 재입력 액션
    func editingChangedReInput(){
        guard let reInputNickname = changeNicknameView.reInputnicknameGroupView.textField.text, let newNickname = changeNicknameView.nicknameGroupView.textField.text  else {
            return
        }
        setNextButton(isActive: reInputNickname == newNickname)
    }
    
    // 닉네임 텍스트 필드에 따른 중복 확인 버튼 활성화
    @objc func editingChangedNickname(){
        let isNotNull = changeNicknameView.nicknameGroupView.textField.text != ""
        setCheckIdButton(isActive: isNotNull)
    }
    
    // 중복확인 버튼 로직
    @objc func touchUpInsideCheckIdButton(){
        let inputChangeNickname = changeNicknameView.nicknameGroupView.textField.text
        /*
         중복 확인 버튼 API 로직 -inputChangeNickname
         MemberAPI.shared.getCheckNickname()
         */
        
        // 중복이 없다면 (아이디 텍스트 필드 수정 불가)
        setNicknameGroupView(isDuplication: false)
        
        // 중복이 있다면
//        setDuplication(isDuplication: true)
        
    }
    
    private func setNicknameGroupView(isDuplication: Bool){
        changeNicknameView.nicknameGroupView.errMessageLabel.text = isDuplication ? "이미 존재하는 닉네임입니다." : "사용 가능한 닉네임입니다."
        changeNicknameView.nicknameGroupView.errMessageLabel.textColor = isDuplication ? .errorRed : .blismBlue
        changeNicknameView.nicknameGroupView.errMessageLabel.isHidden = false
        changeNicknameView.nicknameGroupView.isUserInteractionEnabled = isDuplication
        changeNicknameView.reInputnicknameGroupView.isUserInteractionEnabled = !isDuplication
    }
    
    // 닉네임 변경하기 버튼 로직
    @objc func touchUpInsideNextButton(){
        // Alert - ('고니'로 닉네임을 변경하시겠습니까?')
        guard let newNickname = changeNicknameView.reInputnicknameGroupView.textField.text else { return }
        let alert = UIAlertController(title: "닉네임 변경", message: "\(newNickname)님으로 닉네임을 변경하시곘습니까?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "변경", style: .default, handler: { _ in
            // API 연결
            print("닉네임 변경")
            
            // 키체인 저장
            KeychainService.shared.update(account: .userInfo, service: .nickname, newValue: newNickname)
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        present(alert, animated: true)
    }
    
    private func setCheckIdButton(isActive: Bool){
        changeNicknameView.checkIdButton.isUserInteractionEnabled = isActive
        changeNicknameView.checkIdButton.backgroundColor = isActive ? .blismBlue : .systemGray4
    }
    
    private func setNextButton(isActive: Bool){
        changeNicknameView.nextButton.isUserInteractionEnabled = isActive
        changeNicknameView.nextButton.backgroundColor = isActive ? .blismBlue : .systemGray4
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
