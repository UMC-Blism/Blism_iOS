//
//  SelectDoorDesignViewController.swift
//  Blism
//
//  Created by 이재혁 on 12/19/24.
//

import UIKit

class SelectDoorDesignViewController: UIViewController {

    private lazy var selectDoorView = SelectDoorDesignView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view = selectDoorView
        self.navigationItem.titleView = NavigationTitleView(title: "디자인 선택", titleColor: .blismBlack)
        
        setAction()
        setupDelegate()
    }
    
    private func setAction() {
        selectDoorView.previousButton.addTarget(self, action: #selector(previousButtonAction), for: .touchUpInside)
        selectDoorView.nextButton.addTarget(self, action: #selector(nextButtonAction), for: .touchUpInside)
    }
    
    private func setupDelegate() {
        selectDoorView.selectDoorDesignCollectionView.dataSource = self
        selectDoorView.selectDoorDesignCollectionView.delegate = self
    }
    
    @objc
    private func previousButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func nextButtonAction() {
        guard let selectedIndexPath = selectDoorView.selectDoorDesignCollectionView.indexPathsForSelectedItems?.first else { return }
        
        // 선택된 셀의 태그 가져오기
        let selectedDoorDesignTag = DoorDesignModel.doorDesigns()[selectedIndexPath.row].tag
        
        // 다음 화면에 문 색 정보 태그 전달
        let nextVC = SelectDoorColorViewController()
        nextVC.selectedDoorDesignTag = selectedDoorDesignTag
        self.navigationController?.pushViewController(nextVC, animated: true)
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
