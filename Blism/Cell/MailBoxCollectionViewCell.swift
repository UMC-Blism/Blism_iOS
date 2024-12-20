//
//  MailBoxCollectionViewCell.swift
//  Blism
//
//  Created by 송재곤 on 12/17/24.
//

import UIKit

class MailBoxCollectionViewCell: UICollectionViewCell {
    static let identifier = "doorCollectionView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setComponent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let doorImage = UIImageView().then{
        $0.contentMode = .scaleAspectFill
    }
    
    private func setComponent(){
        addSubview(doorImage)
        
        // se: 667 / 16 pro 874 / 13 mini 812/86: 9.44
        
        doorImage.snp.makeConstraints{
            let height = UIScreen.main.bounds.height / 9.44
            
            $0.width.equalTo(height / 2)
            $0.height.equalTo(height)
            $0.top.equalToSuperview()

        }
    }
    
    public func config(image: UIImage){
        doorImage.image = image
    }
    
}
