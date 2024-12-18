//
//  MyPageTableViewCell.swift
//  Blism
//
//  Created by 이수현 on 12/18/24.
//

import UIKit

class MyPageTableViewCell : UITableViewCell {
    static let id = "MyPageTableViewCell"
    
    // 타이틀
    private let titleLabel = UILabel().then { lbl in
        lbl.text = "임시 라벨"
        lbl.font = .customFont(font: .PretendardLight, ofSize: 15)
    }
    
    // 버톤
    public let selectButton = UIButton().then { btn in
        btn.setImage(.arrow, for: .normal)
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
        [titleLabel, selectButton].forEach{self.addSubview($0)}
    }
    
    private func setUI(){
        // 타이틀 라벨
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(selectButton.snp.leading)
        }
        
        // 버튼
        selectButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(14)
            make.width.equalTo(16)
            make.height.equalTo(32)
        }
    }
    
    public func config(title : String) {
        self.titleLabel.text = title
    }
}
