//
//  SelectDoorColorViewController.swift
//  Blism
//
//  Created by 이재혁 on 12/19/24.
//

import UIKit

class SelectDoorColorViewController: UIViewController {

    private let selectDoorView = SelectDoorColorView()
    var selectedDoorDesignTag: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view = selectDoorView
        self.navigationItem.titleView = NavigationTitleView(title: "디자인 선택", titleColor: .blismBlack)
        
        //setAction()
        setupDelegate()
    }
    
    private func setupDelegate() {
        selectDoorView.selectDoorColorCollectionView.delegate = self
        selectDoorView.selectDoorColorCollectionView.dataSource = self
    }
    

    

}

extension SelectDoorColorViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch selectedDoorDesignTag {
        case 1:
            return DoorDesignModel.doorAColors().count
        case 2:
            return DoorDesignModel.doorBColors().count
        case 3:
            return DoorDesignModel.doorCColors().count
        case 4:
            return DoorDesignModel.doorDColors().count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DoorDesignCollectionViewCell.identifier, for: indexPath) as? DoorDesignCollectionViewCell else { return UICollectionViewCell() }
        
        switch selectedDoorDesignTag {
        case 1:
            let list = DoorDesignModel.doorAColors()
            
            cell.doorDesignImageView.image = list[indexPath.row].image
        case 2:
            let list = DoorDesignModel.doorBColors()
            
            cell.doorDesignImageView.image = list[indexPath.row].image
        case 3:
            let list = DoorDesignModel.doorCColors()
            
            cell.doorDesignImageView.image = list[indexPath.row].image
        case 4:
            let list = DoorDesignModel.doorDColors()
            
            cell.doorDesignImageView.image = list[indexPath.row].image
        default:
            return cell
        }
        
        return cell
    }
    
    
}
