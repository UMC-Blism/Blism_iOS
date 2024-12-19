//
//  NoResultView.swift
//  Blism
//
//  Created by 이재혁 on 12/19/24.
//

import UIKit

class NoResultView: UIView {

    private let noResultImageView = UIImageView().then {
        $0.clipsToBounds = true
        $0.image = .noResultLogo
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
    }
    
    let noResultNicknameLabel = UILabel().then {
        $0.text = "'닉네임'"
        $0.textColor = .blismBlack
        $0.font = .customFont(font: .PretendardLight, ofSize: 15)
    }
    
    private let descriptionLabel = UILabel().then {
        $0.text = "이름에 해당하는 검색결과가 없어요."
        $0.textColor = .blismBlack
        $0.font = .customFont(font: .PretendardLight, ofSize: 15)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubview()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubview() {
        [
            noResultImageView,
            noResultNicknameLabel,
            descriptionLabel
        ].forEach { addSubview($0) }
    }
    
    private func setConstraints() {
        noResultImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()
            $0.width.equalTo(109)
            $0.height.equalTo(116.01)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.centerX.bottom.equalToSuperview()
        }
        
        noResultNicknameLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(descriptionLabel.snp.top).offset(-8)
        }
    }

}
