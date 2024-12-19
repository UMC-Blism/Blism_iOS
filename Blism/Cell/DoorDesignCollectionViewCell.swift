//
//  DoorDesignCollectionViewCell.swift
//  Blism
//
//  Created by 이재혁 on 12/19/24.
//

import UIKit

class DoorDesignCollectionViewCell: UICollectionViewCell {
    static let identifier = "DoorDesignCollectionViewCell"
    
    let doorDesignImageView = UIImageView().then {
        $0.image = .doorA2
        $0.contentMode = .scaleAspectFill
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSelectedState(isSelected: Bool) {
        if isSelected {
            self.layer.borderColor = UIColor(hex: "#E72B6D")?.cgColor
            self.layer.borderWidth = 3
        } else {
            self.layer.borderColor = UIColor(hex: "#B7D2E5")?.cgColor
            self.layer.borderWidth = 3
        }
    }
    
    private func setupView() {
        self.layer.borderColor = UIColor(hex: "#B7D2E5")?.cgColor
        self.layer.borderWidth = 3
        self.layer.cornerRadius = 20
        self.layer.backgroundColor = UIColor(hex: "#3E496C")?.cgColor
        
        addSubview(doorDesignImageView)
    }
    
    private func setupConstraints() {
        doorDesignImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(46)
            $0.height.equalTo(86)
        }
    }
}
