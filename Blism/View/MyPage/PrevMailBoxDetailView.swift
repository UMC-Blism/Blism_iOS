//
//  PrevMailBoxDetailView.swift
//  Blism
//
//  Created by 이수현 on 12/19/24.
//

import UIKit

class PrevMailBoxDetailView: UIView{
    
    private let titleLabel = UILabel().then { lbl in
        lbl.text = "2024년에는 21통의 편지를 받았어요."
        lbl.font = .customFont(font: .PretendardLight, ofSize: 15)
        lbl.textColor = .base2
        lbl.textAlignment = .center
    }
    
    public let collectionView = BuildCollectionView(frame: .zero).then { view in
        view.backgroundColor = UIColor(hex: "#EDEFF4")
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        
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
            titleLabel,
            collectionView
        ].forEach{self.addSubview($0)}
    }
    
    private func setUI(){
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(48)
            make.centerX.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(27)
            make.centerX.equalToSuperview()
            make.width.equalTo(238)
            make.height.equalTo(522)
        }
    }
}
