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
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5) //투명도 50
        
        tapGesture()
        textSetting()
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startAnimation()
    }
    
    private func startAnimation(){
        self.rootView.alpha = 0
        // 화면 띄우는 애니메이션
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
               // 동작할 애니메이션에 대한 코드
            self.rootView.alpha = 1 // 점진적으로 투명도가 1이 됩니다.
        }, completion: nil)
    }
    
    func textSetting(){
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
        UIView.animate(withDuration: 0.1, animations: {
               self.view.alpha = 0 // 투명도 0으로 설정
           }) { _ in
               self.dismiss(animated: false, completion: nil)
           }
    }
}
