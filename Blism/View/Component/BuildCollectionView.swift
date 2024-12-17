//
//  BuildCollectionView.swift
//  Blism
//
//  Created by 송재곤 on 12/17/24.
//

import UIKit
import Then

class BuildCollectionView : UICollectionView {
    
     init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout().then {
            $0.minimumLineSpacing = 14
            $0.estimatedItemSize = .init(width: 46, height: 86)
        }
        super.init(frame: frame, collectionViewLayout: layout)
         self.backgroundColor = .clear
         self.isScrollEnabled = false
         self.register(MailBoxCollectionViewCell.self, forCellWithReuseIdentifier: MailBoxCollectionViewCell.identifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

