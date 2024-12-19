//
//  HomeDoNotDisclosureViewController.swift
//  Blism
//
//  Created by 송재곤 on 12/19/24.
//


import UIKit

class HomeDoNotDisclosureViewController: UIViewController {
    private let rootView = HomeDoNotDisclosureView()


    override func viewDidLoad() {
        super.viewDidLoad()
        view = rootView
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5) //투명도 50
        
        tapGesture()
        
    }
    func tapGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(goBackToHome))
        self.view.addGestureRecognizer(tapGesture)
    }
    @objc func goBackToHome(){
        view.backgroundColor = UIColor.black.withAlphaComponent(0) //투명도 100
        dismiss(animated: true, completion: nil)
    }
}
