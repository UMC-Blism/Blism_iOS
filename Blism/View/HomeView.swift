//
//  SampleView.swift
//  Blism
//
//  Created by 이수현 on 12/16/24.
//

import UIKit
import SnapKit

class HomeView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init")
    }
    
    private let backgroundImage : UIImageView = {
        let image = UIImageView()
        
        image.image = UIImage(named: "검은 배경")
        
        return image
    }()
    
    private let mailboxImage : UIImageView = {
        let image = UIImageView()
        
        image.image = UIImage(named: "mailBox")
        
        return image
    }()
    func setupView(){
        addSubview(backgroundImage)
        addSubview(mailboxImage)
        
        backgroundImage.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        mailboxImage.snp.makeConstraints{
            $0.top.equalToSuperview().offset(99)
            $0.centerX.equalToSuperview()
        }
    }
}
