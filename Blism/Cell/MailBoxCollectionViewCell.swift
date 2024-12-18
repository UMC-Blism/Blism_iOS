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
        
        doorImage.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.width.equalTo(46)
            $0.height.equalTo(86)
        }
    }
    
    public func config(image: UIImage){
        doorImage.image = image
    }
    
}
