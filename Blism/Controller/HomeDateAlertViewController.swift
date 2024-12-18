//
//  HomeDateAlertViewController.swift
//  Blism
//
//  Created by 송재곤 on 12/19/24.
//

import UIKit

class HomeDateAlertViewController: UIViewController {
    private let rootView = HomeDateAlertView()
    public var readLetterPosibleDateReceiver: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        view = rootView
        
        tapGesture()
        
        let updatedText = rootView.alertTitle.text?.replacingOccurrences(of: "0", with: String(readLetterPosibleDateReceiver!))

        let attributedText = NSMutableAttributedString(string: updatedText ?? "")

        // 특정 텍스트 범위를 찾고 속성 적용
        if let range = updatedText?.range(of: "에 열람할수 있어요!") {
            let nsRange = NSRange(range, in: updatedText!)
            
            // 텍스트 색상 적용
            attributedText.addAttribute(.foregroundColor, value: UIColor.black, range: nsRange)
            
            attributedText.addAttribute(.font, value: UIFont.systemFont(ofSize: 16, weight: .regular), range: nsRange) // 굵기 설정
        }

        // 결과적으로 attributedText를 UILabel에 설정
        rootView.alertTitle.attributedText = attributedText
    }
    func tapGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(goBackToHome))
        self.view.addGestureRecognizer(tapGesture)
    }
    @objc func goBackToHome(){
        dismiss(animated: true, completion: nil)
    }
}
