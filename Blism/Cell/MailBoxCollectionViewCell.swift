//
//  MailBoxCollectionViewCell.swift
//  Blism
//
//  Created by 송재곤 on 12/17/24.
//

import UIKit

class MailBoxCollectionViewCell: UICollectionViewCell {
    static let identifier = "MailBoxCollectionView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setComponent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var doorImage = UIImageView().then{
        $0.contentMode = .scaleAspectFill
    }
    func setComponent(){
        addSubview(doorImage)
        
        doorImage.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
}
