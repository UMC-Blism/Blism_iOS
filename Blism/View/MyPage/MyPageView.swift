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
        lbl.text = "김지수님"
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
        lbl.font = .customFont(font: .PretendardBold, ofSize: 28)
        lbl.textColor = .blue1
        lbl.textAlignment = .center
    }
    
    // 우체통 공개 그룹 뷰
    private let openMailBoxGroupView = UIView().then { view in
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.2
    }
    
    private let openMailBoxLabel = UILabel().then { lbl in
        lbl.text = "내 우체통 공개하기"
        lbl.font = .customFont(font: .PretendardLight, ofSize: 15)
        lbl.textColor = .blismBlack
    }
    
    public let openMailBoxToggle = UISwitch().then { sw in
        sw.onTintColor = .blismBlue
    }
    
    // 테이블 뷰
    public let tableView = UITableView(frame: .zero).then { view in
        view.register(MyPageTableViewCell.self, forCellReuseIdentifier: MyPageTableViewCell.id)
        view.separatorStyle = .none
        view.backgroundColor = .clear
        view.showsVerticalScrollIndicator = false
        view.sectionHeaderTopPadding = 0 // 헤더 패딩 제거
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
            openMailBoxLabel,
            openMailBoxToggle
        ].forEach{openMailBoxGroupView.addSubview($0)}
        [
            nicknameLabel,
            dayDescriptionLabel,
            dayLabel
        ].forEach{infoGroupView.addSubview($0)} // 사용자 정보 그룹
        
        [
            backgroundImageView,
            infoGroupView,
            openMailBoxGroupView,
            tableView
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
        
        // 우체통 공개 여부 그룹
        openMailBoxGroupView.snp.makeConstraints { make in
            make.top.equalTo(infoGroupView.snp.bottom).offset(22)
            make.width.equalTo(232)
            make.height.equalTo(53)
            make.centerX.equalToSuperview()
        }
        
        openMailBoxLabel.snp.makeConstraints { make in
            make.leading.equalTo(19)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(openMailBoxToggle.snp.leading)
        }
        
        openMailBoxToggle.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(19)
            make.centerY.equalToSuperview()
            make.width.equalTo(63)
            make.height.equalTo(31)
        }
        
        // tableView
        tableView.snp.makeConstraints { make in
            make.top.equalTo(openMailBoxGroupView.snp.bottom).offset(50)
            make.horizontalEdges.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    public func setUserInfo(nickname: String, dDay: String){
        nicknameLabel.text = "\(nickname)님"
        dayLabel.text = dDay
    }
}
