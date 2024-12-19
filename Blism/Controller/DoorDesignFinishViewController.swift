//
//  DoorDesignFinishViewController.swift
//  Blism
//
//  Created by 이재혁 on 12/19/24.
//

import UIKit

class DoorDesignFinishViewController: UIViewController {

    private let doorDesignFinishView = DoorDesignFinishView()
    var selectedDoorDesignTag: Int = 1
    var selectedDoorColorTag: Int = 1
    var selectedDoorOrnamentTag: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view = doorDesignFinishView
        self.navigationItem.titleView = NavigationTitleView(title: "둥지 완성", titleColor: .blismBlack)
        
        print("design: \(selectedDoorDesignTag)")
        print("color: \(selectedDoorColorTag)")
        print("ornament: \(selectedDoorOrnamentTag)")
        setupDoor()
        setupAction()
    }
    
    private func setupDoor() {
        switch (selectedDoorDesignTag, selectedDoorColorTag) {
        case (1, 1): doorDesignFinishView.doorDesignImageView.image = .doorA1
        case (1, 2): doorDesignFinishView.doorDesignImageView.image = .doorA2
        case (1, 3): doorDesignFinishView.doorDesignImageView.image = .doorA3
        case (1, 4): doorDesignFinishView.doorDesignImageView.image = .doorA4
        case (2, 1): doorDesignFinishView.doorDesignImageView.image = .doorB1
        case (2, 2): doorDesignFinishView.doorDesignImageView.image = .doorB2
        case (2, 3): doorDesignFinishView.doorDesignImageView.image = .doorB3
        case (2, 4):
            doorDesignFinishView.doorDesignImageView.image = .doorB4
        case (3, 1): doorDesignFinishView.doorDesignImageView.image = .doorC1
        case (3, 2): doorDesignFinishView.doorDesignImageView.image = .doorC2
        case (3, 3): doorDesignFinishView.doorDesignImageView.image = .doorC3
        case (3, 4):
            doorDesignFinishView.doorDesignImageView.image = .doorC4
        case (4, 1): doorDesignFinishView.doorDesignImageView.image = .doorD1
        case (4, 2): doorDesignFinishView.doorDesignImageView.image = .doorD2
        case (4, 3): doorDesignFinishView.doorDesignImageView.image = .doorD3
        case (4, 4):
            doorDesignFinishView.doorDesignImageView.image = .doorD4
        default: break
        }
        
        switch selectedDoorOrnamentTag {
        case 1: doorDesignFinishView.doorOrnamentImageView.image = .flower
        case 2: doorDesignFinishView.doorOrnamentImageView.image = .ribbon
        case 3: doorDesignFinishView.doorOrnamentImageView.image = .leece
        case 4: doorDesignFinishView.doorOrnamentImageView.image = .bell
        default: doorDesignFinishView.doorOrnamentImageView.image = nil
        }
    }
    
    private func setupAction() {
        doorDesignFinishView.previousButton.addTarget(self, action: #selector(previousButtonAction), for: .touchUpInside)
        doorDesignFinishView.nextButton.addTarget(self, action: #selector(nextButtonAction), for: .touchUpInside)
    }
    
    @objc
    private func previousButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }

    @objc
    private func nextButtonAction() {
        
    }

}
