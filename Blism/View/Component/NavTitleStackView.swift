//
//  NavTitleStackView.swift
//  Blism
//
//  Created by 송재곤 on 12/19/24.
//
import UIKit

class NavTitleStackView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init")
    }
    
    public var mailboxOwner : UILabel = {
        let label = UILabel()
        
        label.text = "지수님의 우체통"
        label.textColor = .white
        label.font = .customFont(font: .PretendardRegular, ofSize: 24)
        
        return label
    }()
    
    public var mailBoxSubTitle : UILabel = {
        let label = UILabel()
        
        label.text = "편지를 작성해보세요."
        label.textColor = .white
        label.font = .customFont(font: .PretendardRegular, ofSize: 12)
        
        return label
    }()
    
    public var titleStackView: UIStackView = {
        let view = UIStackView()
        
        view.axis = .vertical
        view.alignment = .center
        view.spacing = 3
        
        return view
    }()
    
    func setupView(){
        addSubview(titleStackView)
        titleStackView.addArrangedSubview(mailboxOwner)
        titleStackView.addArrangedSubview(mailBoxSubTitle)
        
        
        
        titleStackView.snp.makeConstraints{

            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
       mailboxOwner.snp.makeConstraints {
           $0.top.equalToSuperview()
           $0.height.equalTo(29)
       }
       
       mailBoxSubTitle.snp.makeConstraints {
           $0.height.equalTo(14)
           $0.top.equalTo(mailboxOwner.snp.bottom)
           $0.centerX.equalTo(mailboxOwner.snp.centerX)
       }
    }
}
