//
//  PrevMailBoxCollectionViewCell.swift
//  Blism
//
//  Created by 이수현 on 12/19/24.
//

import UIKit

class PrevMailBoxCollectionViewCell: UICollectionViewCell{
    static let id = "PrevMailBoxCollectionViewCell"
    
    private let mailBoxImageView = UIImageView().then { view in
        view.image = .prevMailBox
    }
    
    private let yearLabel = UILabel().then { lbl in
        lbl.font = .customFont(font: .PretendardMedium, ofSize: 24)
        lbl.textColor = UIColor(hex: "#314B9E")
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
            mailBoxImageView,
            yearLabel
        ].forEach{self.addSubview($0)}
    }
    
    private func setUI(){
        mailBoxImageView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(7)
        }
        
        yearLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview().multipliedBy(0.95)
            make.centerY.equalToSuperview().multipliedBy(1.1)
        }
    }
    
    public func config(year: String){
        yearLabel.text = year
    }
}
