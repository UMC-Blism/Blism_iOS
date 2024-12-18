//
//  MyPageViewController.swift
//  Blism
//
//  Created by 이수현 on 12/18/24.
//

import UIKit

class MyPageViewController : UIViewController {
    private let myPageView = MyPageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = myPageView
    }
}
