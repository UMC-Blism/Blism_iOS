//
//  ChangeNicknameView.swift
//  Blism
//
//  Created by 이수현 on 12/19/24.
//
import UIKit


class ChangeNicknameView : UIView {
    // 배경
    private let backgroundImageView = BackGroundImageView(type: .white)
    
    // 그룹 뷰
    private let infoGroupView = UIView().then { view in
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 4
        view.backgroundColor = .white
    }
    
    // 닉네임 그룹
    private let nicknameGroupView = UserInfoGroupView(type: .id, title: "변경할 닉네임 (아이디)", errMessage: "이미 존재하는 닉네임입니다.")
    
    // 닉네임 중복 확인 버튼
    public let checkIdButton = LoginViewButton(type: .checkId)
    
    // 재입력 닉네임 그룹
    private let reInputnicknameGroupView = UserInfoGroupView(type: .id, title: "닉네임 재입력", errMessage: "입력한 닉네임을 다시 확인해주세요.")
    
    // 다음 버튼
    public let nextButton = UIButton().then { btn in
        btn.setTitle("닉네임 변경하기", for: .normal)
        btn.titleLabel?.font = .customFont(font: .PretendardRegular, ofSize: 15)
        btn.setTitleColor(.base2, for: .normal)
        btn.backgroundColor = .blismBlue
        btn.layer.cornerRadius = 10
        btn.clipsToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setSubView()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubView(){
        
        nicknameGroupView.addSubview(checkIdButton)
        
        [
            nicknameGroupView,
            reInputnicknameGroupView,
            nextButton
        ].forEach{infoGroupView.addSubview($0)}
        
        [
            backgroundImageView,
            infoGroupView
        ].forEach{self.addSubview($0)}
    }
    
    private func setUI(){
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        infoGroupView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(306)
            make.height.equalTo(420)
        }
        
        nicknameGroupView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(53)
            make.horizontalEdges.equalToSuperview().inset(18)
            make.height.equalTo(94)
        }
        
        nicknameGroupView.textField.snp.updateConstraints { make in
            make.width.equalTo(168)
        }
        
        // 중복 확인 버튼
        checkIdButton.snp.makeConstraints { make in
            make.top.equalTo(nicknameGroupView.textField)
            make.trailing.equalToSuperview()
//            make.leading.equalTo(nicknameGroupView.textField.snp.trailing).offset(16)
            make.width.equalTo(85)
            make.height.equalTo(45)
        }
        
        reInputnicknameGroupView.snp.makeConstraints { make in
            make.top.equalTo(nicknameGroupView.snp.bottom).offset(38)
            make.horizontalEdges.equalToSuperview().inset(18)
            make.height.equalTo(94)
        }
        
        nextButton.snp.makeConstraints { make in
            make.width.equalTo(122)
            make.height.equalTo(45)
            make.trailing.equalToSuperview().inset(18)
            make.bottom.equalToSuperview().inset(50)
        }
    }
}
