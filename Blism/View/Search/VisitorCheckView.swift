//
//  VisitorCheckView.swift
//  Blism
//
//  Created by 이수현 on 12/19/24.
//

import UIKit

class VisitorCheckView: UIView {
    
    private let onwerNickname: String
    
    init(onwerNickname: String){
        self.onwerNickname = onwerNickname
        super.init(frame: .zero)
        
        setSubView()
        setUI()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    private let nicknameGroupView = UIView()
    
    // 아이디 라벨
    private let nicknameLabel = UILabel().then { lbl in
        let visitText = "방문"
        let text = "\(visitText) 할 우체통 닉네임 (아이디)"
        lbl.font = .customFont(font: .PretendardRegular, ofSize: 15)
        
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.foregroundColor, value: UIColor.blue1 ?? .black, range: (text as NSString).range(of: visitText))
        attributedText.addAttribute(.font, value: UIFont.customFont(font: .PretendardBold, ofSize: 15), range: (text as NSString).range(of: visitText))
        lbl.attributedText = attributedText
    }
    
    // 닉네임 텍스트 필드
    private lazy var nicknameTextField = LoginTextField(type: .visitMailBox).then { txt in
        txt.text = onwerNickname
        txt.isUserInteractionEnabled = false
    }
    
    
    // 확인코드 그룹
    private let checkCodeGroupView = UIView()
    
    private let checkCodeLabel = UILabel().then { lbl in
        lbl.text = "확인 코드"
        lbl.font = .customFont(font: .PretendardRegular, ofSize: 15)
    }
    
    // 확인 코드 텍스트 필드
    public let checkCodeTextField = LoginTextField(type: .checkCode)
    
    // 방문 버튼
    public let visitButton = UIButton().then { btn in
        btn.setTitle("방문하기", for: .normal)
        btn.titleLabel?.font = .customFont(font: .PretendardRegular, ofSize: 15)
        btn.setTitleColor(.base2, for: .normal)
        btn.layer.cornerRadius = 10
        btn.clipsToBounds = true
        
        btn.backgroundColor = .systemGray4
        btn.isUserInteractionEnabled = false
    }
    
    private func setSubView(){
        [
            nicknameLabel,
            nicknameTextField,
        ].forEach{nicknameGroupView.addSubview($0)}
        
        [
            checkCodeLabel,
            checkCodeTextField,
        ].forEach{checkCodeGroupView.addSubview($0)}
        
        [
            nicknameGroupView,
            checkCodeGroupView,
            visitButton,
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
            make.height.equalTo(372)
        }
        
        nicknameGroupView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(73)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(72)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(5)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(44)
        }
        
        checkCodeGroupView.snp.makeConstraints { make in
            make.top.equalTo(nicknameGroupView.snp.bottom).offset(54)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(72)
        }
        
        checkCodeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(5)
        }
        
        checkCodeTextField.snp.makeConstraints { make in
            make.top.equalTo(checkCodeLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(44)
        }
        
        visitButton.snp.makeConstraints { make in
            make.width.equalTo(85)
            make.height.equalTo(45)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(24)
        }
    }
}
