//
//  LetterListTableViewCell.swift
//  Blism
//
//  Created by 이수현 on 12/19/24.
//

import UIKit

class LetterListTableViewCell : UITableViewCell {
    static let id = "LetterListTableViewCell"
    
    // 날짜
    private let dateLabel = UILabel().then { lbl in
        lbl.text = "2024⋅12⋅12⋅목요일"
        lbl.font = .customFont(font: .PretendardLight, ofSize: 15)
        lbl.textColor = .blismBlack
    }
    
    // 편지 그룹
    private let letterGroupView = UIView().then { view in
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 0.2
        view.layer.shadowOpacity = 4
        view.layer.masksToBounds = false
    }
    
    // 편지 백그라운드 이미지
    private let letterBackgroundImageView = UIImageView().then { view in
        view.image = .letterListBackground
    }
    
    // 받은 사람
    private let receivedNicknameLabel = UILabel().then { lbl in
        lbl.text = "To. 답장 받을 사람"
        lbl.font = .customFont(font: .PretendardLight, ofSize: 15)
        lbl.tintColor = .blismBlack
    }
    
    // 편지 내용
    private let contentLabel = UILabel().then { lbl in
        lbl.text = "편지내용편지내용편지내용편지내용편지내용편지내용편지내용편지내용편지내용편지내용편지내용편지내용편지내용편지내용편지내용편지내용"
        lbl.font = .customFont(font: .PretendardLight, ofSize: 15)
        lbl.tintColor = .blismBlack
        lbl.numberOfLines = 3
    }
    // 보낸 사람
    private let sentNicknameLabel = UILabel().then { lbl in
        lbl.text = "From. 답장 보낸 사람"
        lbl.font = .customFont(font: .PretendardLight, ofSize: 15)
        lbl.tintColor = .blismBlack
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setSubView()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubView(){
        [
            letterBackgroundImageView,
            receivedNicknameLabel,
            contentLabel,
            sentNicknameLabel
        ].forEach{letterGroupView.addSubview($0)}
        
        [
            dateLabel,
            letterGroupView
        ].forEach{self.addSubview($0)}
    }
    
    private func setUI(){
        // 날짜 라벨
        dateLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.top.trailing.equalToSuperview()
            make.leading.equalToSuperview().inset(7)
        }
        
        // 편지 그룹 뷰
        letterGroupView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(19)
            make.trailing.equalToSuperview().inset(22)
            make.top.equalTo(dateLabel.snp.bottom).offset(6)
            make.height.equalTo(151)
        }
        
        // 받을 사람
        receivedNicknameLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(17)
        }
        
        // 편지 본문
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(receivedNicknameLabel.snp.bottom).offset(10)
            make.bottom.equalTo(sentNicknameLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(17)
            make.trailing.equalToSuperview().inset(13)
        }
        // 보낸 사람
        sentNicknameLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(17)
            make.trailing.equalToSuperview().inset(13)
        }
    }
}
