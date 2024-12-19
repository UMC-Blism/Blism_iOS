//
//  SearchHistoryTableViewCell.swift
//  Blism
//
//  Created by 이재혁 on 12/19/24.
//

import UIKit

class SearchHistoryTableViewCell: UITableViewCell {

    static let identifier = "SearchHistoryTableViewCell"
    
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
    
    let historyNameLabel = UILabel().then {
        $0.font = .customFont(font: .PretendardLight, ofSize: 15)
        $0.textColor = .blismBlack
    }
    
    let deleteButton = UIButton().then {
        $0.setImage(.close, for: .normal)
        $0.tintColor = UIColor(hex: "#575A61")
    }
    
    private func setViews() {
        self.backgroundColor = .clear
        
        [
            historyNameLabel,
            deleteButton
        ].forEach { self.addSubview($0) }
    }
    
    private func setConstraints() {
        historyNameLabel.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
        }
        
        deleteButton.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalTo(11)
        }
    }

}
