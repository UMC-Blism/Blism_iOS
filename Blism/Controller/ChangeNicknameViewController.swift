//
//  ChangeNicknameViewController.swift
//  Blism
//
//  Created by 이수현 on 12/19/24.
//

import UIKit

class ChangeNicknameViewController: UIViewController{
    private let changeNicknameView = ChangeNicknameView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = changeNicknameView
    }
}
