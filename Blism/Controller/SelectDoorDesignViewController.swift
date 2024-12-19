//
//  SelectDoorDesignViewController.swift
//  Blism
//
//  Created by 이재혁 on 12/19/24.
//

import UIKit

class SelectDoorDesignViewController: UIViewController {

    private let selectDoorView = SelectDoorDesignView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view = selectDoorView
        self.navigationItem.titleView = NavigationTitleView(title: "디자인 선택", titleColor: .blismBlack)
        
        setAction()
        setupDelegate()
    }
    
    private func setAction() {
        
    }
    
    private func setupDelegate() {
        selectDoorView.selectDoorDesignCollectionView.dataSource = self
        selectDoorView.selectDoorDesignCollectionView.delegate = self
    }

}

extension SelectDoorDesignViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DoorDesignModel.doorDesigns().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DoorDesignCollectionViewCell.identifier, for: indexPath) as? DoorDesignCollectionViewCell else { return UICollectionViewCell() }
        
        let list = DoorDesignModel.doorDesigns()
        
        cell.doorDesignImageView.image = list[indexPath.row].image
        
        return cell
    }
    
    
}
