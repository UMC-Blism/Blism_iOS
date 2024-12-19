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
        
        setAction()
        setupDelegate()
        setNavigationBar()
    }
    
    private func setNavigationBar(){
        // 뒤로 가기 버튼
        let leftBarButton = UIBarButtonItem(image: .popIcon, style: .plain, target: self, action: #selector(popAction))
        leftBarButton.tintColor = .blismBlack
        self.navigationItem.setLeftBarButton(leftBarButton, animated: true)
        
        // 타이틀
        self.navigationItem.titleView = NavigationTitleView(title: "디자인 선택", titleColor: .blismBlack)
    }
    
    @objc
    private func popAction(){
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setAction() {
        selectDoorView.previousButton.addTarget(self, action: #selector(previousButtonAction), for: .touchUpInside)
        selectDoorView.nextButton.addTarget(self, action: #selector(nextButtonAction), for: .touchUpInside)
    }
    
    private func setupDelegate() {
        selectDoorView.selectDoorColorCollectionView.delegate = self
        selectDoorView.selectDoorColorCollectionView.dataSource = self
    }
    
    @objc
    private func previousButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func nextButtonAction() {
        guard let selectedIndexPath = selectDoorView.selectDoorColorCollectionView.indexPathsForSelectedItems?.first else { return }
        
        // 선택된 셀의 태그 가져오기
        let selectedDoorColorTag = DoorDesignModel.doorDesigns()[selectedIndexPath.row].tag
        
        // 다음 화면에 문 색 정보 태그 전달
        let nextVC = SelectDoorOrnamentViewController()
        nextVC.selectedDoorDesignTag = selectedDoorDesignTag
        nextVC.selectedDoorColorTag = selectedDoorColorTag
        self.navigationController?.pushViewController(nextVC, animated: true)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? DoorDesignCollectionViewCell {
            cell.configureSelectedState(isSelected: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? DoorDesignCollectionViewCell {
            cell.configureSelectedState(isSelected: false)
        }
    }
    
}
