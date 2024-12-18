//
//  SplashView.swift
//  Blism
//
//  Created by 이수현 on 12/19/24.
//

import UIKit

final class SplashView : UIView {
    
    // 배경
    private let backgroundImageView = UIImageView().then { view in
        view.image = .whiteBackground
    }
    
    // 로고
    private let logoImageView = UIImageView().then { view in
        view.image = .splashLogo
    }
    
    // 타이틀
    private let titleLabel = UILabel().then { lbl in
        lbl.text = "Blism"
        lbl.font = .customFont(font: .Inter, ofSize: 40)
        lbl.textColor = .blismBlack
        lbl.textAlignment = .center
    }
    
    // 서브 타이틀
    private let subTitleLabel = UILabel().then { lbl in
        lbl.text = "소중한 사람에게 편지를 전달해요."
        lbl.font = .customFont(font: .PretendardLight, ofSize: 12)
        lbl.textColor = .blismBlack
        lbl.textAlignment = .center
    }
    
    // 설명
    private let descriptionLabel = UILabel().then { lbl in
        lbl.text = "파랑새가 편지를 물어오고 있어요.\n잠시만 기다려주세요"
        lbl.font = .customFont(font: .PretendardLight, ofSize: 15)
        lbl.textColor = .blismBlack
        lbl.numberOfLines = 2
        lbl.textAlignment = .center
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
            backgroundImageView,
            logoImageView,
            titleLabel,
            subTitleLabel,
            descriptionLabel
        ].forEach{self.addSubview($0)}
    }
    
    private func setUI(){
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        logoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().multipliedBy(0.7)
            make.centerX.equalToSuperview()
            make.width.equalTo(109)
            make.height.equalTo(116)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
            make.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
        }
    }
}
