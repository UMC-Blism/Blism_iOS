//
//  WriteLetterViewController.swift
//  Blism
//
//  Created by 이재혁 on 12/18/24.
//

import UIKit

class WriteLetterViewController: UIViewController {

    private let writeView = WriteLetterView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = writeView
        self.navigationItem.titleView = NavigationTitleView(title: "편지 작성하기", titleColor: .blismBlack)
    }
    
}
