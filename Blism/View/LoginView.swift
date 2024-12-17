//
//  LoginView.swift
//  Blism
//
//  Created by 이수현 on 12/17/24.
//

import UIKit
import Then
import SnapKit

class LoginView : UIView {
    // 로고 + 로그인 뷰 그룹
    private let groupView = UIView()
    
    // 로고 그룹 뷰 (로고 이미지, 로고 라벨)
    private let logoGroupView = UIView()
    
    // 로고 이미지 뷰
    private let logoImageView = UIImageView().then { view in
        view.image = UIImage(named: "Logo")?.withRenderingMode(.alwaysOriginal)
        view.contentMode = .scaleAspectFit
    }
    
    // 로고 라벨
    private let logoLabel = UILabel().then { lbl in
        lbl.text = "소중한 사람에게 편지를 전달해요."
        lbl.font = .systemFont(ofSize: 12, weight: UIFont.Weight(300))
        lbl.textAlignment = .center
    }
    
    // 로그인 그룹
    private let loginGroupView = UIView().then { view in
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        // shadow 설정
    }
    
    // 아이디 그룹
    private let idGroupView = UIView()
    
    // 아이디 라벨
    private let idLabel = UILabel().then { lbl in
        lbl.text = "로그인 할 닉네임 (아이디)" // attributed로 변경해야 함
        lbl.font = .systemFont(ofSize: 15, weight: UIFont.Weight(600))
    }
    
    // 아이디 텍스트 필드
    private let idTextField = LoginTextField(type: .id)
    
    public let checkIdButton = UIButton().then { btn in
        btn.setTitle("아이디 중복 확인하기", for: .normal)
        btn.setTitleColor(UIColor(hex: "#314B9E"), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 12, weight: UIFont.Weight(300))
    }
    
    // 비밀번호 그룹
    private let passwordGroupView = UIView()
    
    // 비밀번호 라벨
    private let passwordLabel = UILabel().then { lbl in
        lbl.text = "비밀번호"
        lbl.font = .systemFont(ofSize: 15, weight: UIFont.Weight(rawValue: 300))
        lbl.tintColor = UIColor(hex: "#1A274F")
    }
    
    // 비밀번호 텍스트 필드
    private let passwordTextField = LoginTextField(type: .id)
    
    public let loginButton = UIButton().then {btn in
        btn.setTitle("블리즘 시작하기", for: .normal)
        btn.setTitleColor( UIColor(hex: "#FFF8EF"), for: .normal)
        btn.backgroundColor = UIColor(hex: "#6C8FC6")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setSubView()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubView(){
        [
            logoImageView,
            logoLabel
        ].forEach{logoGroupView.addSubview($0)} // 로고 그룹
        
        [
            idLabel,
            idTextField,
            checkIdButton
        ].forEach{idGroupView.addSubview($0)} // 아이디 그룹
        
        [
            passwordLabel,
            passwordTextField,
            loginButton
        ].forEach{passwordGroupView.addSubview($0)} // 비밀번호 그룹
        
        [
            idGroupView,
            passwordGroupView,
        ].forEach{loginGroupView.addSubview($0)} // 로그인 그룹
        
        [
            logoGroupView, // 로고 그룹
            loginGroupView // 로그인 그룹
        ].forEach{groupView.addSubview($0)} // 로고 + 로그인 그룹
        
        self.addSubview(groupView)
    }
    
    private func setUI(){
        
        // 전체 그룹
        groupView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(105)
            make.centerX.equalToSuperview()
            make.width.equalTo(306)
            make.height.equalTo(561)
        }
        
        // 로고 그룹
        logoGroupView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(192)
            make.height.equalTo(144)
        }
        
        // 로고 라벨
        logoLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(14)
        }
        
        // 로고 이미지 뷰
        logoImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(logoLabel.snp.top).offset(14)
        }
        
        // 로그인 그룹 뷰
        loginGroupView.snp.makeConstraints { make in
            make.top.equalTo(logoGroupView.snp.bottom).offset(45)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        
        // 아이디 그룹 뷰
        idGroupView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(73)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(97)
        }
        
        // 아이디 라벨
        idLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        // 아이디 텍스트 필드
        idTextField.snp.makeConstraints { make in
            make.top.equalTo(idLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        
        // 중복 확인 버튼
        checkIdButton.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview()
            make.width.equalTo(97)
            make.height.equalTo(20)
        }
        
        // 비밀번호 그룹
        passwordGroupView.snp.makeConstraints { make in
            make.top.equalTo(loginGroupView.snp.bottom).offset(29)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(17)
        }
        
        // 비밀번호 라벨
        passwordLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }
        
        // 비밀번호 텍스트 필드
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        
        // 로그인 버튼
        loginButton.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview()
            make.height.equalTo(45)
            make.width.equalTo(122)
        }
    }
}
