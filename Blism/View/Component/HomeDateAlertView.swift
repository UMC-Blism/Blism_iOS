//
//  HomeDateAlertView.swift
//  Blism
//
//  Created by 송재곤 on 12/19/24.
//

import UIKit

class HomeDateAlertView: UIView {
    
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
        
        label.text = "12월 0일에 열람할수 있어요!"
        
        label.textColor = UIColor.blismBlue
        label.font = .customFont(font: .PretendardSemiBold, ofSize: 16)
        
        return label
    }()
    
    func setupView(){
        addSubview(alert)
        addSubview(alertTitle)
        
        alert.snp.makeConstraints{
            $0.top.equalTo(safeAreaLayoutGuide).offset(328)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(272)
            $0.height.equalTo(163)
        }
        
        alertTitle.snp.makeConstraints{
            $0.centerX.centerY.equalTo(alert)
        }
    }
}
