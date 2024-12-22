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
        selectOrnamentView.noOrnamentButton.addTarget(self, action: #selector(noORnamentButtonAction), for: .touchUpInside)
    }
    
    private func setupDelegate() {
        selectOrnamentView.selectDoorOrnamentCollectionView.delegate = self
        selectOrnamentView.selectDoorOrnamentCollectionView.dataSource = self
    }
    
    private func setNoOrnamentButtonConfiguration(color: String) {
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .base1
        
        var titleAttr = AttributedString.init("장식 없이")
        titleAttr.font = .customFont(font: .PretendardSemiBold, ofSize: 15)
        titleAttr.foregroundColor = .blismBlack
        
        configuration.attributedTitle = titleAttr
        configuration.background.strokeColor = UIColor(hex: color)
        configuration.background.strokeWidth = 2
        
        selectOrnamentView.noOrnamentButton.translatesAutoresizingMaskIntoConstraints = false
        selectOrnamentView.noOrnamentButton.configuration = configuration
    }
    
    @objc
    private func previousButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }

    @objc
    private func nextButtonAction() {
        var selectedDoorOrnamentTag = 0
        
        let selectedIndexPath = selectOrnamentView.selectDoorOrnamentCollectionView.indexPathsForSelectedItems?.first ?? IndexPath(row: -1, section: 0)
        if selectedIndexPath.row == -1 {
            selectedDoorOrnamentTag = 0
        } else {
            // 선택된 셀 태그 가져오기
            selectedDoorOrnamentTag =  DoorDesignModel.doorOrnaments()[selectedIndexPath.row].tag
        }
        
        WriteLetterData.shared.decorationDesign = selectedDoorOrnamentTag
        
        // 완성 화면에 문 정보 전부 전달
        let nextVC = DoorDesignFinishViewController()
        nextVC.selectedDoorDesignTag = selectedDoorDesignTag
        nextVC.selectedDoorColorTag = selectedDoorColorTag
        nextVC.selectedDoorOrnamentTag = selectedDoorOrnamentTag
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc
    private func noORnamentButtonAction() {
        // 선택된 셀의 indexPath 가져오기
        guard let selectedIndexPath = selectOrnamentView.selectDoorOrnamentCollectionView.indexPathsForSelectedItems?.first else { return }
        selectOrnamentView.selectDoorOrnamentCollectionView.deselectItem(at: selectedIndexPath, animated: true)
        // 셀 상태 업데이트
        if let cell = selectOrnamentView.selectDoorOrnamentCollectionView.cellForItem(at: selectedIndexPath) as? DoorOrnamentCollectionViewCell {
            cell.configureSelectedState(isSelected: false)
        }
        
        // 안고르기 버튼 업데이트
        setNoOrnamentButtonConfiguration(color: "#E72B6D")
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
            setNoOrnamentButtonConfiguration(color: "#B7D2E5")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? DoorOrnamentCollectionViewCell {
            cell.configureSelectedState(isSelected: false)
        }
    }
    
}
