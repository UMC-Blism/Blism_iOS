//
//  VisiterCheckViewController.swift
//  Blism
//
//  Created by 이수현 on 12/19/24.
//

import UIKit
class VisiterCheckViewController : UIViewController {
    private let visiterCheckView = VisiterCheckView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = visiterCheckView
    }
}
