//
//  NavigationTitleView.swift
//  Blism
//
//  Created by 이수현 on 12/18/24.
//

import UIKit

class NavigationTitleView : UIView {
    private let title : String
    private let titleColor : UIColor?
    
    private lazy var titleLabel = UILabel().then { lbl in
        lbl.text = title
        lbl.font = .customFont(font: .PretendardLight, ofSize: 24)
        lbl.textColor = titleColor
        lbl.textAlignment = .center
    }
    
    init(title : String, titleColor : UIColor?){
        self.title = title
        self.titleColor = titleColor
        super.init(frame: .zero)
        setSubView()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubView(){
        addSubview(titleLabel)
    }
    
    private func setUI(){
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
