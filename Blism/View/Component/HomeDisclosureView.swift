//
//  HomeDateAlertView.swift
//  Blism
//
//  Created by 송재곤 on 12/19/24.
//

import UIKit

class HomeDisclosureView: UIView {
    
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
        
        label.text = "다른사람에게 메시지 내용을 공개할까요?"
        
        label.textColor = .blue
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    private lazy var yesButton: UIButton = {
        
        let btn = UIButton()
        
        btn.setTitle("네", for: .normal)
        btn.backgroundColor = .blue
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        
        return btn
    }()
    
    private lazy var noButton: UIButton = {
        
        let btn = UIButton()
        
        btn.setTitle("아니오", for: .normal)
        btn.backgroundColor = .blue
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        
        return btn
    }()
    
    func setupView(){
        addSubview(alert)
        addSubview(alertTitle)
        addSubview(yesButton)
        addSubview(noButton)
        
        alert.snp.makeConstraints{
            $0.top.equalTo(safeAreaLayoutGuide).offset(323.5)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(272)
            $0.height.equalTo(166)
        }
        
        alertTitle.snp.makeConstraints{
            $0.centerX.equalTo(alert)
            $0.top.equalTo(alert.snp.top).offset(30)
        }
        yesButton.snp.makeConstraints{
            $0.top.equalTo(alertTitle.snp.bottom).offset(25)
            $0.leading.equalTo(alertTitle.snp.leading)
            $0.width.equalTo(80)
            $0.height.equalTo(45)
        }
        noButton.snp.makeConstraints{
            $0.top.equalTo(alertTitle.snp.bottom).offset(25)
            $0.trailing.equalTo(alertTitle.snp.trailing)
            $0.width.equalTo(80)
            $0.height.equalTo(45)
        }
    }
}
