//
//  ReadLetterViewController.swift
//  Blism
//
//  Created by 송재곤 on 12/17/24.
//

import UIKit

class ReadLetterViewController: UIViewController {
    private let rootView = ReadLetterView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = rootView
        
        tapGesture()
    }
    func tapGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(goBackToHome))
        self.view.addGestureRecognizer(tapGesture)
        rootView.backgroundImageView.isUserInteractionEnabled = false
    }
    @objc func goBackToHome(){
        dismiss(animated: true, completion: nil)
    }
}
