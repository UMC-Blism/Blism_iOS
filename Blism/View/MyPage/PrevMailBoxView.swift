//
//  PrevMailBoxView.swift
//  Blism
//
//  Created by 이수현 on 12/19/24.
//

import UIKit

class PrevMailBoxView: UIView {
    private let backgroundImageView = BackGroundImageView(type: .black)
    
    private let nullDataGroupView = UIView()
    
    private let logoImageView = UIImageView().then { view in
        view.image = .splashLogo
    }
    
    private let titleLabel = UILabel().then { lbl in
        lbl.text = "에전에 받은 우체통이 없어요."
        lbl.font = .customFont(font: .PretendardLight, ofSize: 15)
        lbl.textColor = .white
        lbl.textAlignment = .center
    }
    
    
    public let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then({ layout in
        layout.itemSize = CGSize(width: 160, height: 232)
    })).then { view in
        view.register(PrevMailBoxCollectionViewCell.self, forCellWithReuseIdentifier: PrevMailBoxCollectionViewCell.id)
        view.backgroundColor = .clear
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
            logoImageView,
            titleLabel
        ].forEach{nullDataGroupView.addSubview($0)}
        
        [
            backgroundImageView,
            nullDataGroupView,
            collectionView
        ].forEach{self.addSubview($0)}
    }
    
    private func setUI(){
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        nullDataGroupView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.7)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(171)
            make.height.equalTo(159)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(60)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(30)
        }
    }
    
    public func isNullData(isNull : Bool){
        collectionView.isHidden = isNull ? true : false
        nullDataGroupView.isHidden = isNull ? false : true
    }
}
