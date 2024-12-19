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
        startAnimation()
    }
    
    private func startAnimation(){
        self.splashView.alpha = 0
        // 화면 띄우는 애니메이션
        UIView.animate(withDuration: 1.7, delay: 0, options: .curveEaseOut, animations: {
               // 동작할 애니메이션에 대한 코드
                self.splashView.alpha = 1 // 점진적으로 투명도가 1이 됩니다.
        }, completion: nil)
    }
}
