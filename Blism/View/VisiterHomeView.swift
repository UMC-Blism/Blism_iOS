//
//  VisiterHomeView.swift
//  Blism
//
//  Created by 송재곤 on 12/19/24.
//

import UIKit
import SnapKit

class VisiterHomeView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init")
    }
    
    public let backButton: UIButton = {
        let btn = UIButton()
        
        btn.setImage(UIImage(named: "popIcon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.tintColor = UIColor.white
        btn.layer.masksToBounds = true
        
        return btn
    }()
    
    private let backgroundImage : UIImageView = {
        let image = UIImageView()
        
        image.image = UIImage(named: "blackBackground")
        
        return image
    }()
    
    private let mailboxImage : UIImageView = {
        let image = UIImageView()
        
        image.image = UIImage(named: "mailBox")
        
        return image
    }()
    
    public var doorCollectionView = BuildCollectionView(frame: .zero)
    
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
    
    public let writeLetter: UIButton = {
        let btn = UIButton()
        
        btn.setTitle("편지 쓰기", for: .normal)
        btn.backgroundColor = UIColor.blismBlue
        btn.titleLabel?.textColor = .white
        btn.titleLabel?.font = .customFont(font: .PretendardSemiBold, ofSize: 15)
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        
        return btn
    }()
    
    
   
    
    func setupView(){
        addSubview(backgroundImage)
        addSubview(mailboxImage)
        addSubview(doorCollectionView)
        addSubview(writeLetter)

        
        backgroundImage.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }

    
        mailboxImage.snp.makeConstraints{
            $0.top.equalTo(safeAreaLayoutGuide).offset(25)
            $0.centerX.equalToSuperview()
        }
        
        doorCollectionView.snp.makeConstraints{
            $0.top.equalTo(mailboxImage.snp.top).offset(137)
            $0.centerX.equalTo(mailboxImage)
            $0.bottom.equalTo(mailboxImage.snp.bottom).offset(-65)
            $0.width.equalTo(286)
        }
        writeLetter.snp.makeConstraints{
            $0.top.equalTo(doorCollectionView.snp.bottom).offset(18)
            $0.centerX.equalTo(doorCollectionView.snp.centerX)
            $0.width.equalTo(111)
            $0.height.equalTo(45)
        }
    }
}
