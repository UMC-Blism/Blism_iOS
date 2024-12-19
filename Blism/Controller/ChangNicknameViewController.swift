//
//  CheckNicknameViewController.swift
//  Blism
//
//  Created by 이수현 on 12/19/24.
//

import UIKit

class CheckNicknameViewController : UIViewController {
    private let changeNicknameView = CheckNicknameView()
    
    override func viewDidLoad() {
        self.view = changeNicknameView
    }
}
