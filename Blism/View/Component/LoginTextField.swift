//
//  LoginTextField.swift
//  Blism
//
//  Created by 이수현 on 12/17/24.
//

import UIKit

public enum LoginTextFieldType : String{
    case id = "id"
    case password = "password"
}

final class LoginTextField : UITextField {
    private let type : LoginTextFieldType
    
    init(type : LoginTextFieldType) {
        self.type = type
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTextField(){
        self.backgroundColor = UIColor(hex: "#EDEFF4")
        self.layer.cornerRadius = 20
        self.placeholder = self.type == .id ? "아이디를 입력해주세요" : "비밀번호를 입력해주세요"
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 19, height: 1))
        self.font = .systemFont(ofSize: 15, weight: UIFont.Weight(300))
    }
}
