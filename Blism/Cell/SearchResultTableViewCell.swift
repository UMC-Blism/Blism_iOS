//
//  SearchResultTableViewCell.swift
//  Blism
//
//  Created by 이재혁 on 12/19/24.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {

    static let identifier = "SearchResultTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setViews()
        self.setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nicknameLabel = UILabel().then {
        $0.text = "닉네임"
        $0.font = .customFont(font: .PretendardSemiBold, ofSize: 15)
        $0.textColor = .blismBlack
    }
    
    private let visitLabel = UILabel().then {
        $0.text = "우체통 방문하기"
        $0.font = .customFont(font: .PretendardLight, ofSize: 15)
        $0.textColor = .blismBlack
    }
    
    let visitButton = UIButton().then {
        $0.setImage(.arrow, for: .normal)
        $0.tintColor = .blismBlack
    }
    
    private func setViews() {
        self.layer.cornerRadius = 10
        self.backgroundColor = .white
        
        [
            nicknameLabel,
            visitLabel,
            visitButton
        ].forEach { self.addSubview($0) }
    }
    
    private func setConstraints() {
        nicknameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
        
        visitButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(16)
            $0.height.equalTo(32)
        }
        
        visitLabel.snp.makeConstraints {
            $0.trailing.equalTo(visitButton.snp.leading).offset(-15)
            $0.centerY.equalToSuperview()
        }
    }
}
