//
//  SplashViewController.swift
//  Blism
//
//  Created by 이수현 on 12/19/24.
//

import UIKit

class SplashViewController : UIViewController {
    private let splashView = SplashView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view = splashView
        
        self.splashView.alpha = 0 // 이미지의 투명도를 0으로 변경
           UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseOut, animations: {
                  // 동작할 애니메이션에 대한 코드
                   print("애니메이션 실행!")
                   self.splashView.alpha = 1 // 점진적으로 투명도가 1이 됩니다.
                   }, completion: nil)
    }
}
