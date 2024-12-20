//
//  SampleView.swift
//  Blism
//
//  Created by 이수현 on 12/16/24.
//

import UIKit
import SnapKit

class HomeView: UIView {
    var height = UIScreen.main.bounds.height
    var mailboxImageHeigth = 0.0
    
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
        label.numberOfLines = 1
        
        return label
    }()
    
    public var numberOfMail : UILabel = {
        let label = UILabel()
        
        label.text = "n개의 둥지가 완성됐어요!"
        label.textColor = .white
        label.font = .customFont(font: .PretendardRegular, ofSize: 12)
        
        return label
    }()
    
    func setupView(){
        addSubview(backgroundImage)
        addSubview(mailboxImage)
        addSubview(doorCollectionView)
        addSubview(mailboxOwner)
        addSubview(numberOfMail)
        
        backgroundImage.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        mailboxOwner.snp.makeConstraints{
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.equalTo(safeAreaLayoutGuide).offset(16)
            $0.trailing.equalTo(numberOfMail.snp.leading)
        }
        numberOfMail.snp.makeConstraints{
            $0.centerY.equalTo(mailboxOwner.snp.centerY)
            $0.trailing.equalToSuperview().offset(-15.5)
        }

        mailboxImage.snp.makeConstraints{
            mailboxImageHeigth = height / 1.23 + 10
            // se: 667 / 16 pro 874 /
            // 13 mini height - 812 / 658: 1.23
            // 13 mini width - 812 / 343: 2.36
            $0.top.equalTo(numberOfMail.snp.bottom).offset(19.5)
            $0.centerX.equalToSuperview().multipliedBy(1.02)

            $0.height.equalTo(mailboxImageHeigth)
            $0.width.equalTo(mailboxImageHeigth / 2)
        }
        
        doorCollectionView.snp.makeConstraints{
//          13 mini height 812 / 126 : 6.44 - top 비율
            let doorCollectionViewTop = height / 6.44 + 5
            $0.top.equalTo(mailboxImage.snp.top).offset(doorCollectionViewTop)

            $0.centerX.equalTo(mailboxImage)
            
            //  657 : 53 = 12.39
            let bottomInset = mailboxImageHeigth / 12.39
            print(bottomInset)
            $0.bottom.equalTo(mailboxImage.snp.bottom).inset(bottomInset)
            
            // 13 mini mailboxImage width : 343 / 286 : 1.19
            let width = mailboxImageHeigth / 2
            $0.width.equalTo(width / 1.19)
        }
    }
}

