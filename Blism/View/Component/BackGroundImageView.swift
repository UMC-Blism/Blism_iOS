//
//  WhiteBackGroundImageView.swift
//  Blism
//
//  Created by 이수현 on 12/18/24.
//

import UIKit

public enum BackGroundImageType {
    case white
    case black
    case translucenceBlack // 반투명
}

// 흰 배경
final class BackGroundImageView : UIImageView {
    init(type : BackGroundImageType){
        super.init(frame: .zero)
        setImageView(type: type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setImageView(type : BackGroundImageType){
        switch type {
        case .white:
            self.image = .whiteBackground
        case .black:
            self.image = .blackBackground
        case .translucenceBlack:
            self.image = .translucenceBlack
        }
    }
}
