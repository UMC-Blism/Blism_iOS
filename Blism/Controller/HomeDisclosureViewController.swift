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
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5) //투명도 50
        
        tapGesture()
        
        textSetting()
        
    }
    
    func textSetting(){
        let updatedText = rootView.alertTitle.text

        let attributedText = NSMutableAttributedString(string: updatedText ?? "")

        // 특정 텍스트 범위를 찾고 속성 적용
        if let range = updatedText?.range(of: "우체통") {
            let nsRange = NSRange(range, in: updatedText!)
            
            // 텍스트 색상 적용
            attributedText.addAttribute(.foregroundColor, value: UIColor.blue1 ?? UIColor.blue, range: nsRange)
            
            attributedText.addAttribute(.font, value: UIFont.systemFont(ofSize: 16, weight: .semibold), range: nsRange) // 굵기 설정
        }

        // 결과적으로 attributedText를 UILabel에 설정
        rootView.alertTitle.attributedText = attributedText
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
