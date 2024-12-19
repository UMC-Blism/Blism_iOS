//
//  PrevMailBoxDetailView.swift
//  Blism
//
//  Created by 이수현 on 12/19/24.
//

import UIKit

class PrevMailBoxDetailView: UIView{
    
    private let backgroundImageView = BackGroundImageView(type: .black)
    private let title : String
    
    private lazy var titleLabel = UILabel().then { lbl in
        lbl.text = title
        lbl.font = .customFont(font: .PretendardLight, ofSize: 15)
        lbl.textColor = .base2
        lbl.textAlignment = .center
    }
    
    public let collectionView = BuildCollectionView(frame: .zero).then { view in
        view.backgroundColor = UIColor(hex: "#EDEFF4")
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.contentInset = UIEdgeInsets(top: 22, left: 21, bottom: 22, right: 21)
        
    }
    
    init(year: String, count: Int){
        title = "\(year)년에는 \(count)통의 편지를 받았어요."
        super.init(frame: .zero)
        
        setSubView()
        setUI()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubView(){
        [
            backgroundImageView,
            titleLabel,
            collectionView
        ].forEach{self.addSubview($0)}
    }
    
    private func setUI(){
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(48)
            make.centerX.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(27)
            make.centerX.equalToSuperview()
            make.width.equalTo(328)
            make.height.equalTo(522)
        }
    }
}
