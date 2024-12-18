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
    }
    
}
