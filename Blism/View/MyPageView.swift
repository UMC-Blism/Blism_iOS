//
//  MyPageView.swift
//  Blism
//
//  Created by 이수현 on 12/18/24.
//

import UIKit

class MyPageView : UIView {
    // 백그라운드 이미지
    private let backgroundImageView = BackGroundImageView(type: .white)
    
    // 사용자 정보 그룹
    private let infoGroupView = UIView().then { view in
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.2
        view.layer.masksToBounds = false
    }
    
    // 닉네임 라벨 (닉네임만 따로 받아야 함)
    private let nicknameLabel = UILabel().then { lbl in
        lbl.text = "김지수 님"
        lbl.font = .customFont(font: .PretendardSemiBold, ofSize: 15)
        lbl.textColor = .blue1
        lbl.textAlignment = .center
    }
    
    // "우체통이 열리기까지"
    private let dayDescriptionLabel = UILabel().then { lbl in
        lbl.text = "우체통이 열리기까지"
        lbl.textAlignment = .center
        lbl.font = .customFont(font: .PretendardLight, ofSize: 15)
        lbl.textColor = .blismBlack
    }
    
    // D-Day
    private let dayLabel = UILabel().then { lbl in
        lbl.text = "D-28일"
        lbl.font = .customFont(font: .PretendardBold, ofSize: 24)
        lbl.textColor = .blue1
        lbl.textAlignment = .center
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setSubView()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubView(){
        [
            nicknameLabel,
            dayDescriptionLabel,
            dayLabel
        ].forEach{infoGroupView.addSubview($0)} // 사용자 정보 그룹
        
        [
            backgroundImageView,
            infoGroupView,
        ].forEach{self.addSubview($0)}
    }
    
    private func setUI(){
        
        // 백그라운드 이미지
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // 사용자 정보 그룹
        infoGroupView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(62)
            make.centerX.equalToSuperview()
            make.width.equalTo(204)
            make.height.equalTo(102)
        }
        
        // 닉네임 라벨
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12.5)
            make.horizontalEdges.equalToSuperview()
        }
        
        // "우체통이 열리기까지"
        dayDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview()
        }
        
        // d-day
        dayLabel.snp.makeConstraints { make in
            make.top.equalTo(dayDescriptionLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().inset(12.5)
        }
    }
}
