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
        
        print("design: \(selectedDoorDesignTag)")
        print("color: \(selectedDoorColorTag)")
        print("ornament: \(selectedDoorOrnamentTag)")
        setupDoor()
        setupAction()
        setNavigationBar()
    }
    
    private func setNavigationBar(){
        // 뒤로 가기 버튼
        let leftBarButton = UIBarButtonItem(image: .popIcon, style: .plain, target: self, action: #selector(popAction))
        leftBarButton.tintColor = .blismBlack
        self.navigationItem.setLeftBarButton(leftBarButton, animated: true)
        
        // 타이틀
        self.navigationItem.titleView = NavigationTitleView(title: "둥지 완성", titleColor: .blismBlack)
    }
    
    @objc
    private func popAction(){
        self.navigationController?.popViewController(animated: true)
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
        guard let navigationController = navigationController else { return }

        // VisiterHomeViewController를 스택에서 찾기
        if let targetIndex = navigationController.viewControllers.firstIndex(where: { $0 is VisiterHomeViewController }) {
            // VisiterHomeViewController까지의 스택만 유지
            let newStack = Array(navigationController.viewControllers[...targetIndex])
            navigationController.setViewControllers(newStack, animated: true)
            
            // VisitorHomeViewController에서 탭바 다시 보이도록
            if let visitorHomeVC = navigationController.viewControllers.last as? VisiterHomeViewController {
                visitorHomeVC.tabBarController?.isTabBarHidden = false
            }
        }
    }

}

/*
 var presentingVC = self.presentingViewController
  
  // 특정 ViewController를 찾을 때까지 presentingViewController를 따라 올라감
  while let parent = presentingVC {
      if parent is TabBarController { // 원하는 뷰 컨트롤러 타입 체크
          parent.dismiss(animated: true) // 특정 뷰를 찾으면 모든 모달 닫기
          return
      }
      presentingVC = parent.presentingViewController
      
  }
 */
