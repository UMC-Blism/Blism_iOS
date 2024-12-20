//
//  DoorDesignFinishView.swift
//  Blism
//
//  Created by 이재혁 on 12/19/24.
//

import UIKit

class DoorDesignFinishView: UIView {

    // 백그라운드 이미지 뷰
    private let backgroundImageView = BackGroundImageView(type: .white)
    
    // 설명 라벨
    private let descriptionLabel = UILabel().then {
        $0.text = "둥지가 완성됐어요!"
        $0.font = .customFont(font: .PretendardRegular, ofSize: 15)
        $0.textColor = .blismBlack
    }

    let doorDesignImageView = UIImageView().then {
        $0.image = .doorABlank
        $0.contentMode = .scaleAspectFill
        $0.isUserInteractionEnabled = false
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let doorOrnamentImageView = UIImageView().then {
        $0.image = .bell
        $0.contentMode = .scaleAspectFill
        $0.isUserInteractionEnabled = false
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // 이전, 다음 버튼 그룹
    private let buttonGroupView = UIView()
    
    let previousButton = UIButton().then {
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = UIColor(hex: "#FFFFFF")
        
        var titleAttr = AttributedString.init("이전")
        titleAttr.font = .customFont(font: .PretendardSemiBold, ofSize: 15)
        titleAttr.foregroundColor = .blismBlack
        
        configuration.attributedTitle = titleAttr
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.configuration = configuration
    }
    
    let nextButton = UIButton().then {
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .blismBlue
        
        var titleAttr = AttributedString.init("다음")
        titleAttr.font = .customFont(font: .PretendardSemiBold, ofSize: 15)
        titleAttr.foregroundColor = .white
        
        configuration.attributedTitle = titleAttr
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.configuration = configuration
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubview()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubview() {
        [
            backgroundImageView,
            descriptionLabel,
            doorDesignImageView,
            buttonGroupView
        ].forEach { addSubview($0) }
        
        [
            doorOrnamentImageView
        ].forEach { doorDesignImageView.addSubview($0) }
        
        [
            previousButton,
            nextButton
        ].forEach { buttonGroupView.addSubview($0) }
    }
    
    private func setUI() {
        doorOrnamentImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(28)
            $0.leading.equalToSuperview().inset(15)
            $0.width.height.equalTo(60)
        }
        
        previousButton.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(128)
        }
        
        nextButton.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(128)
        }
        
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(doorDesignImageView.snp.top).offset(-50)
        }
        
        doorDesignImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalTo(107)
            $0.height.equalTo(200)
        }
        
        buttonGroupView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(313)
            $0.height.equalTo(45)
        }
    }
}
