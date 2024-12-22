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
    // 백그라운드 이미지 뷰
    private let backgroundImageView = BackGroundImageView(type: .white)
    
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
        lbl.font = .customFont(font: .PretendardLight, ofSize: 12)
        lbl.tintColor = .blismBlack
        lbl.textAlignment = .center
    }
    
    // 로그인 그룹
    private let loginGroupView = UIView().then { view in
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        // shadow 설정
        view.layer.shadowColor = UIColor.black.cgColor          // 그림자 색상: #000000
        view.layer.shadowOpacity = 0.2                          // 그림자 불투명도 (0.0 ~ 1.0)
        view.layer.shadowOffset = CGSize(width: 0, height: 4)   // X:0 , Y: 4
        view.layer.shadowRadius = 4                             // Blur: 4
        view.layer.masksToBounds = false                        // 그림자가 뷰 바깥으로 잘리지 않도록 설정
    }
    
    // 아이디 그룹
    private let idGroupView = UIView()
    
    // 아이디 라벨
    private let idLabel = UILabel().then { lbl in
        let login = "로그인"
        let text = "\(login) 할 닉네임 (아이디)"
        lbl.font = .customFont(font: .PretendardRegular, ofSize: 15)
        
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.foregroundColor, value: UIColor.blue1 ?? .black, range: (text as NSString).range(of: login))
        attributedText.addAttribute(.font, value: UIFont.customFont(font: .PretendardBold, ofSize: 15), range: (text as NSString).range(of: login))
        lbl.attributedText = attributedText
    }
    // 닉네임 그룹
    public let checkNicknameLabel = UILabel().then { lbl in
        lbl.text = "이미 존재하는 닉네임입니다."
        lbl.font = .customFont(font: .PretendardBold, ofSize: 10)
        lbl.textColor = UIColor.errorRed
    }
    
    // 아이디 텍스트 필드
    public let idTextField = LoginTextField(type: .id)
    
    
    // 중복 확인 버튼
    public let checkIdButton = LoginViewButton(type: .checkId).then { btn in
        btn.isUserInteractionEnabled = false
        btn.backgroundColor = .systemGray4
    }
    
    // 비밀번호 그룹
    private let passwordGroupView = UIView()
    
    // 비밀번호 라벨
    private let passwordLabel = UILabel().then { lbl in
        lbl.text = "확인코드 생성"
        lbl.font = .customFont(font: .PretendardRegular, ofSize: 15)
        lbl.tintColor = .blismBlack
    }
    
    // 비밀번호 텍스트 필드
    public let passwordTextField = LoginTextField(type: .password).then { txt in
        txt.isUserInteractionEnabled = false
        txt.textColor = .blismBlue
        
    }
    
    // 생성하기 버튼
    public let createCodeButton = LoginViewButton(type: .createCode).then { btn in
        btn.isUserInteractionEnabled = false
        btn.backgroundColor = .systemGray4
    }
    
    // 확인코드 설명 라벨
    private let codeDesriptionLabel = UILabel().then { lbl in
        lbl.text = "생성된 코드로 다른 사름의 우체통에 접속하거나 \n내 우체통에 초대가 가능해요."
        lbl.font = .customFont(font: .PretendardSemiBold, ofSize: 10)
        lbl.numberOfLines = 2
        lbl.tintColor = .blismBlack
    }
    
    public let loginButton = UIButton().then {btn in
        btn.setTitle("블리즘 시작하기", for: .normal)
        btn.setTitleColor(.base2, for: .normal)
        btn.backgroundColor = .systemGray4
        btn.layer.cornerRadius = 10
        btn.titleLabel?.font = .customFont(font: .PretendardMedium, ofSize: 15)
        btn.isUserInteractionEnabled = false
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
            checkNicknameLabel,
            checkIdButton
        ].forEach{idGroupView.addSubview($0)} // 아이디 그룹
        
        [
            passwordLabel,
            passwordTextField,
            createCodeButton,
        ].forEach{passwordGroupView.addSubview($0)} // 비밀번호 그룹
        
        [
            idGroupView,
            passwordGroupView,
            codeDesriptionLabel,
            loginButton
        ].forEach{loginGroupView.addSubview($0)} // 로그인 그룹
        
        [
            backgroundImageView,
            logoGroupView, // 로고 그룹
            loginGroupView // 로그인 그룹
        ].forEach{self.addSubview($0)}
    }
    
    private func setUI(){
        
        // 백그라운드 이미지
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // 로고 그룹
        logoGroupView.snp.makeConstraints { make in
//            print(UIScreen.main.bounds.height) // 874, 667
            let inset = UIScreen.main.bounds.height > 700 ? 65 : 30 // 16pro height : 874, se : 667
            make.top.equalTo(safeAreaLayoutGuide).inset(inset)
            make.centerX.equalToSuperview()
        }
        
        // 로고 이미지 뷰
        logoImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.width.equalTo(192)
            make.height.equalTo(120)
        }
        
        // 로고 라벨
        logoLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(14)
            make.horizontalEdges.bottom.equalToSuperview()
        }

        
        // 로그인 그룹 뷰
        loginGroupView.snp.makeConstraints { make in
            let height = UIScreen.main.bounds.height > 700 ? 400 : 350 // 16pro height : 874, se : 667
            make.top.equalTo(logoGroupView.snp.bottom).offset(45)
            make.horizontalEdges.equalToSuperview().inset(35)
            make.height.equalTo(height)
        }
        
        // 아이디 그룹 뷰
        idGroupView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(35)
            make.horizontalEdges.equalToSuperview().inset(18)
        }
        
        // 아이디 라벨
        idLabel.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.leading.equalToSuperview().offset(5)
            make.height.equalTo(20)
        }
        
        // 아이디 텍스트 필드
        idTextField.snp.makeConstraints { make in
            make.top.equalTo(idLabel.snp.bottom).offset(10)
            make.leading.bottom.equalToSuperview()
        }
        
        // 아이디 에러 라벨
        checkNicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(idTextField.snp.bottom).offset(9)
            make.leading.equalToSuperview().offset(5)
            make.height.equalTo(12)
        }
        
        // 중복 확인 버튼
        checkIdButton.snp.makeConstraints { make in
            make.top.equalTo(idLabel.snp.bottom).offset(10)
            make.trailing.bottom.equalToSuperview()
            make.leading.equalTo(idTextField.snp.trailing).offset(16)
            make.width.equalTo(85)
            make.height.equalTo(45)
        }
        
        // 비밀번호 그룹
        passwordGroupView.snp.makeConstraints { make in
            make.top.equalTo(idGroupView.snp.bottom).offset(40)
            make.horizontalEdges.equalToSuperview().inset(18)
        }
        
        // 비밀번호 라벨
        passwordLabel.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.leading.equalToSuperview().offset(5)
            make.height.equalTo(20)
        }
        
        // 비밀번호 텍스트 필드
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(10)
            make.leading.bottom.equalToSuperview()
        }
        
        // 생성하기 버튼
        createCodeButton.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(10)
            make.trailing.bottom.equalToSuperview()
            make.leading.equalTo(passwordTextField.snp.trailing).offset(16)
            make.width.equalTo(85)
            make.height.equalTo(45)
        }
        
        // 코드 설명
        codeDesriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordGroupView.snp.bottom).offset(10)
            make.leading.equalTo(passwordGroupView).offset(5)
            make.trailing.equalTo(passwordGroupView)
        }
        
        // 로그인 버튼
        loginButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(18)
            make.bottom.equalToSuperview().inset(32)
            make.height.equalTo(45)
            make.width.equalTo(122)
        }
    }
}
