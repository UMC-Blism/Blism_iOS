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
    }
}
