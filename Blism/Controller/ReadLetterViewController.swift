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
        
        let updatedTextReceiver = rootView.letterReceiver.text
        let updatedTextSender = rootView.letterSender.text


        let attributedText1 = NSMutableAttributedString(string: updatedTextReceiver ?? "")
        let attributedText2 = NSMutableAttributedString(string: updatedTextSender ?? "")

        // 특정 텍스트 범위를 찾고 속성 적용
        if let range = updatedTextReceiver?.range(of: "받는 사람") {
            let nsRange = NSRange(range, in: updatedTextReceiver!)
            
            // 텍스트 색상 적용
            attributedText1.addAttribute(.foregroundColor, value: UIColor.blismBlue ?? UIColor.blue, range: nsRange)
            
            attributedText1.addAttribute(.font, value: UIFont.systemFont(ofSize: 15, weight: .semibold), range: nsRange) // 굵기 설정
        }
        
        // 특정 텍스트 범위를 찾고 속성 적용
        if let range = updatedTextSender?.range(of: "보내는 사람") {
            let nsRange = NSRange(range, in: updatedTextSender!)
            
            // 텍스트 색상 적용
            attributedText2.addAttribute(.foregroundColor, value: UIColor.blismBlue ?? UIColor.blue, range: nsRange)
            
            attributedText2.addAttribute(.font, value: UIFont.systemFont(ofSize: 15, weight: .semibold), range: nsRange) // 굵기 설정
        }

        // 결과적으로 attributedText를 UILabel에 설정
        rootView.letterReceiver.attributedText = attributedText1
        rootView.letterSender.attributedText = attributedText2
        
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
