//
//  LoginView.swift
//  Blism
//
//  Created by 이수현 on 12/17/24.
//

import UIKit
import Then
import SnapKit

final class LoginView : UIView {
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
    }
    
    private func setUI(){
        
    }
}
