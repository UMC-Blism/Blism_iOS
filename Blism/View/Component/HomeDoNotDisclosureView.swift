//
//  HomeDoNotDisclosureView.swift
//  Blism
//
//  Created by 송재곤 on 12/19/24.
//

import UIKit

class HomeDoNotDisclosureView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public var alert: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    public var alertTitle : UILabel = {
        let label = UILabel()
        
        label.text = "비공개 우체통이에요."
        
        label.textColor = UIColor.blismBlack
        label.font = .customFont(font: .PretendardRegular, ofSize: 15)
        label.textAlignment = .center
        label.numberOfLines = 2
        
        return label
    }()
    
    
    func setupView(){
        addSubview(alert)
        addSubview(alertTitle)
        
        alert.snp.makeConstraints{
            $0.top.equalTo(safeAreaLayoutGuide).offset(323.5)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(272)
            $0.height.equalTo(166)
        }
        
        alertTitle.snp.makeConstraints{
            $0.centerX.centerY.equalTo(alert)
        }
    }
}
