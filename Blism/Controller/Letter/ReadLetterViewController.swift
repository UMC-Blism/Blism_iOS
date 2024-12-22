//
//  ReadLetterViewController.swift
//  Blism
//
//  Created by 송재곤 on 12/17/24.
//

import UIKit

class ReadLetterViewController: UIViewController {

    private var isFirstAppear = true
    private let letterId : Int64
    private let replyId: Int64?
    
    private let type: LetterListType
    private let rootView : ReadLetterView
    
    init(type: LetterListType, letterId: Int64, replyId: Int64? = nil) {
        self.type = type
        self.letterId = letterId
        self.replyId = replyId
        rootView = ReadLetterView()
        rootView.setButton(type: type)
        super.init(nibName: nil, bundle: nil)
        
        // 정보 가져오기 API
        self.getInfo()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view = rootView
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5) //투명도 50
        
        tapGesture()
        textSetting()
        goToReply()
        addAction()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if isFirstAppear {  // 첫 번째 호출일 때만 실행
            startAnimation()
            isFirstAppear = false  // 이후에는 애니메이션을 실행하지 않음
        }
    }
    
    private func getInfo(){
        switch type {
        case .receivedReply, .sentReply:
            self.getReplyInfo()
        case .writingLetter, .home:
            self.getLetterInfo()
        }
    }
    
    // 편지 정보 가져오기 API
    private func getLetterInfo(){
        // type에 따라, switch - case로 ReadLetter - ReadReply 구분 필욜할듯
        let request = ReadLetterRequest(letterId: letterId)
        // API 통신 후 성공하면 ReadLetterView config에 적용
        LetterRequest.shared.readLetter(request: request) {[weak self] result in
            switch result {
            case .success(let response):
                if response.isSuccess {
                    self?.rootView.config(letterInfo: response.result)
                    self?.textSetting()
                } else {
                    print("getLetterInfo - isSuccess == false")
                    let alert = NetworkAlert.shared.getAlertController(title: "isSucess: false")
                    self?.present(alert, animated: true)
                }
            case .failure(let error):
                let alert = NetworkAlert.shared.getAlertController(title: error.description)
                self?.present(alert, animated: true)
            }
        }
    }
    
    // 답장 정보 가져오기 API
    private func getReplyInfo() {
        guard let replyId = replyId else {return}
        
    }
    
    private func startAnimation(){
        self.rootView.alpha = 0
        // 화면 띄우는 애니메이션
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
               // 동작할 애니메이션에 대한 코드
            self.rootView.alpha = 1 // 점진적으로 투명도가 1이 됩니다.
        }, completion: nil)
    }
    
    private func addAction(){
        rootView.backButton.addTarget(self, action: #selector(goBackToHome), for: .touchUpInside)
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
        
        rootView.replyButton.addTarget(self, action: #selector(goToReply), for: .touchUpInside)
        rootView.replyButton.isUserInteractionEnabled = true
    }
    
    @objc func goBackToHome(){
        UIView.animate(withDuration: 0.1, animations: {
               self.view.alpha = 0 // 투명도 0으로 설정
           }) { _ in
               self.dismiss(animated: false, completion: nil)
           }
    }
    
    @objc func goToReply(){
        
        let replyViewController = ReplyLetterViewController()
        
        // 내비게이션 컨트롤러가 있을 경우 처리
           if let navigationController = self.navigationController {
               navigationController.pushViewController(replyViewController, animated: true)
           } else {
               // 내비게이션 컨트롤러가 없으면 새로 만들어서 모달로 띄우기
               let navController = UINavigationController(rootViewController: replyViewController)
               navController.modalPresentationStyle = .fullScreen // 전체 화면으로 표시
               self.present(navController, animated: true, completion: nil)
           }
        
        print("1")
    }
    
}
