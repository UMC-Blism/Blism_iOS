//
//  HomeDateAlertViewController.swift
//  Blism
//
//  Created by 송재곤 on 12/19/24.
//

import UIKit

class HomeDisclosureViewController: UIViewController {
    private let rootView = HomeDisclosureView()


    override func viewDidLoad() {
        super.viewDidLoad()
        view = rootView
        
        tapGesture()
        
    }
    func tapGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(goBackToHome))
        self.view.addGestureRecognizer(tapGesture)
    }
    @objc func goBackToHome(){
        dismiss(animated: true, completion: nil)
    }
}
