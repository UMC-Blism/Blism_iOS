//
//  UserInfoGroupView.swift
//  Blism
//
//  Created by 이수현 on 12/19/24.
//

import UIKit

class UserInfoGroupView : UIView {
    private let type: LoginTextFieldType    // 타입
    private let title: String           // 타이틀
    private let errMessage: String      // 오류 메시지
    
    // 타이틀
    private lazy var titleLabel = UILabel().then { lbl in
        lbl.text = title
        lbl.font = .customFont(font: .PretendardLight, ofSize: 15)
        lbl.textColor = .blismBlack
    }
    
    // 텍스트 필드
    public lazy var textField = LoginTextField(type: type)
    
    // 에러 라벨
    public lazy var errMessageLabel = UILabel().then { lbl in
        lbl.text = errMessage
        lbl.font = .customFont(font: .PretendardMedium, ofSize: 10)
        lbl.textColor = UIColor(hex: "#E72B6D")
        lbl.isHidden = true
    }
    
    init(type: LoginTextFieldType, title: String, errMessage: String) {
        self.type = type
        self.title = title
        self.errMessage = errMessage
        
        super.init(frame: .zero)
        setSubView()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubView(){
        [
            titleLabel,
            textField,
            errMessageLabel
        ].forEach{self.addSubview($0)}
    }
    
    private func setUI(){
        titleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }
        
        textField.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.width.equalTo(270)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.height.equalTo(45)
        }
        
        errMessageLabel.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(9)
            make.horizontalEdges.equalToSuperview().inset(5)
        }
    }
}
