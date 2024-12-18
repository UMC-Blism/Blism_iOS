//
//  LoginViewButton.swift
//  Blism
//
//  Created by 이수현 on 12/18/24.
//

import UIKit

public enum LoginViewButtonType {
    case checkId
    case createCode
}

final class LoginViewButton : UIButton {
    private let type : LoginViewButtonType
    init(type : LoginViewButtonType) {
        self.type = type
        super.init(frame: .zero)
        setButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setButton(){
        self.setTitle(type == .checkId ? "중복확인" : "생성하기", for: .normal)
        self.setTitleColor(.base2, for: .normal)
        self.titleLabel?.font = .customFont(font: .PretendardMedium, ofSize: 15)
        self.backgroundColor = .blismBlue
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
    }
}
