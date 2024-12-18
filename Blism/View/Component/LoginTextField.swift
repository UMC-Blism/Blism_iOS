//
//  LoginTextField.swift
//  Blism
//
//  Created by 이수현 on 12/17/24.
//

import UIKit

public enum LoginTextFieldType {
    case id
    case password
}

final class LoginTextField : UITextField {
    private let type : LoginTextFieldType
    
    init(type : LoginTextFieldType) {
        self.type = type
        super.init(frame: .zero)
        setTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTextField(){
        self.backgroundColor = UIColor(hex: "#EDEFF4")
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 19, height: 1))
        self.leftViewMode = .always
        self.font = .customFont(font: .PretendardRegular, ofSize: 12)
        self.layer.cornerRadius = 20
        self.placeholder = self.type == .id ? "아이디를 입력해주세요." : "확인코드를 기억해주세요."

    }
}
