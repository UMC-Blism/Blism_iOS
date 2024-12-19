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
        label.font = .systemFont(ofSize: 24)
        
        return label
    }()
    
    public var numberOfMail : UILabel = {
        let label = UILabel()
        
        label.text = "n개의 둥지가 완성됐어요!"
        label.textColor = .white
        label.font = .systemFont(ofSize: 12)
        
        return label
    }()
    
    public let searchButton: UIImageView = {
        let btn = UIImageView()
        
        btn.image = UIImage(named: "search")
        
        return btn
    }()
    
    public let menuButton: UIImageView = {
        let btn = UIImageView()
        
        btn.image = UIImage(named: "menu")
        
        return btn
    }()
    
   
    
    func setupView(){
        addSubview(backgroundImage)
        addSubview(mailboxImage)
        addSubview(doorCollectionView)
        addSubview(mailboxOwner)
        addSubview(numberOfMail)
        addSubview(searchButton)
        addSubview(menuButton)
        
        backgroundImage.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        mailboxOwner.snp.makeConstraints{
            $0.top.equalTo(safeAreaLayoutGuide).offset(44)
            $0.leading.equalTo(safeAreaLayoutGuide).offset(16)
        }
        numberOfMail.snp.makeConstraints{
            $0.top.equalTo(mailboxOwner.snp.bottom).offset(3)
            $0.leading.equalTo(safeAreaLayoutGuide).offset(16)
        }
        searchButton.snp.makeConstraints{
            $0.top.equalTo(safeAreaLayoutGuide).offset(52)
            $0.trailing.equalTo(menuButton.snp.leading).offset(-20)
            $0.width.height.equalTo(32)
        }
        menuButton.snp.makeConstraints{
            $0.width.height.equalTo(32)
            $0.top.equalTo(safeAreaLayoutGuide).offset(52)
            $0.trailing.equalTo(safeAreaLayoutGuide).offset(-16)
        }
        mailboxImage.snp.makeConstraints{
            $0.top.equalTo(mailboxOwner.snp.bottom).offset(25)
            $0.centerX.equalToSuperview()
        }
        
        doorCollectionView.snp.makeConstraints{
            $0.top.equalTo(mailboxImage.snp.top).offset(137)
            $0.centerX.equalTo(mailboxImage)
            $0.bottom.equalTo(mailboxImage.snp.bottom).offset(-65)
            $0.width.equalTo(286)
        }
    }
}

