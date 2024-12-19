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
    private let nicknameGroupView = UserInfoGroupView(type: .id, title: "기존 닉네임 (아이디)", errMessage: "닉네임을 다시 입력해주세요.")
    
    
    // 확인코드 그룹
    private let checkCodeGroupView = UserInfoGroupView(type: .checkCode, title: "확인 코드 입력", errMessage: "코드를 다시 확인해주세요.")
    
    // 다음 버튼
    public let nextButton = UIButton().then { btn in
        btn.setTitle("다음", for: .normal)
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
        [
            nicknameGroupView,
            checkCodeGroupView,
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
        
        checkCodeGroupView.snp.makeConstraints { make in
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
