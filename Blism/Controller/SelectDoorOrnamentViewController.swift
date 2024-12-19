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
        guard let selectedIndexPath = selectOrnamentView.selectDoorOrnamentCollectionView.indexPathsForSelectedItems?.first else { return }
        
        // 선택된 셀 태그 가져오기
        let selectedDoorOrnamentTag = DoorDesignModel.doorOrnaments()[selectedIndexPath.row].tag
        
        // 완성 화면에 문 정보 전부 전달
        let nextVC = DoorDesignFinishViewController()
        nextVC.selectedDoorDesignTag = selectedDoorDesignTag
        nextVC.selectedDoorColorTag = selectedDoorColorTag
        nextVC.selectedDoorOrnamentTag = selectedDoorOrnamentTag
        self.navigationController?.pushViewController(nextVC, animated: true)
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
