//
//  SelectDoorOrnamentViewController.swift
//  Blism
//
//  Created by 이재혁 on 12/19/24.
//

import UIKit

class SelectDoorOrnamentViewController: UIViewController {

    private let selectOrnamentView = SelectDoorOrnamentView()
    var selectedDoorDesignTag: Int = 1
    var selectedDoorColorTag: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view = selectOrnamentView
        self.navigationItem.titleView = NavigationTitleView(title: "디자인 선택", titleColor: .blismBlack)
        
        setAction()
        setupDelegate()
    }
    
    private func setAction() {
        selectOrnamentView.previousButton.addTarget(self, action: #selector(previousButtonAction), for: .touchUpInside)
        selectOrnamentView.nextButton.addTarget(self, action: #selector(nextButtonAction), for: .touchUpInside)
    }
    
    private func setupDelegate() {
        selectOrnamentView.selectDoorOrnamentCollectionView.delegate = self
        selectOrnamentView.selectDoorOrnamentCollectionView.dataSource = self
    }
    
    @objc
    private func previousButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }

    @objc
    private func nextButtonAction() {
        
    }
}

extension SelectDoorOrnamentViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DoorDesignModel.doorOrnaments().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DoorOrnamentCollectionViewCell.identifier, for: indexPath) as? DoorOrnamentCollectionViewCell else { return UICollectionViewCell() }
        
        let list = DoorDesignModel.doorOrnaments()
        
        cell.doorOrnamentImageView.image = list[indexPath.row].image
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? DoorOrnamentCollectionViewCell {
            cell.configureSelectedState(isSelected: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? DoorOrnamentCollectionViewCell {
            cell.configureSelectedState(isSelected: false)
        }
    }
    
}
