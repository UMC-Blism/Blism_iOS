//
//  EditLetterViewController.swift
//  Blism
//
//  Created by 이재혁 on 12/22/24.
//

import UIKit
import Kingfisher

class EditLetterViewController: UIViewController {

    private let rootView = WriteLetterView()
    private let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = rootView
        setNavigationBar()
        
        setGesture()
        setImagePicker()
        setDelegate()
        setAction()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        spreadData()
    }
    
    private func spreadData() {
        let letterData = EditLetterData.shared
        
        rootView.textView.text = letterData.content
        rootView.placeholderLabel.text = ""
        rootView.sendButton.setTitle("편지 수정하기", for: .normal)
        rootView.toggleLabel.isHidden = false
        rootView.toggleSwitch.isHidden = false
        rootView.toggleSwitch.isOn = letterData.visibility == 1 ? true : false
        rootView.imageAttachView.kf.setImage(with: URL(string: letterData.photoUrl))
        let count = rootView.textView.text.count
        rootView.charCountLabel.text = "\(count)/150"
        
        rootView.senderNameLabel.text = letterData.senderNickname
        rootView.receiverNameLabel.text = letterData.receiverNickname
        
    }
    
    private func setGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openImagePicker))
        
        rootView.imageAttachView.addGestureRecognizer(tapGesture)
    }
    
    private func setImagePicker() {
        self.picker.sourceType = .photoLibrary
        self.picker.modalPresentationStyle = .fullScreen
    }
    
    private func setAction() {
        rootView.sendButton.addTarget(self, action: #selector(touchUpInsideSendButton), for: .touchUpInside)
        
        rootView.fontOption1Button.addTarget(self, action: #selector(changeFontOption1), for: .touchUpInside)
        rootView.fontOption2Button.addTarget(self, action: #selector(changeFontOption2), for: .touchUpInside)
        rootView.fontOption3Button.addTarget(self, action: #selector(changeFontOption3), for: .touchUpInside)
        rootView.fontOption4Button.addTarget(self, action: #selector(changeFontOption4), for: .touchUpInside)
    }
    
    private func setDelegate() {
        rootView.textView.delegate = self
        self.picker.delegate = self
    }
    
    private func editLetterWithData() {
        // 편지 데이터 저장
        let letterData = EditLetterData.shared
        letterData.attachedImage = rootView.imageAttachView.image
        letterData.content = rootView.textView.text
        letterData.visibility = rootView.toggleSwitch.isOn == true ? 1 : 0
        
        guard let image = rootView.imageAttachView.image else { return }
        
        let requestBody = EditLetterRequest(
            senderId: letterData.senderId,
            receiverId: letterData.receiverId,
            mailboxId: letterData.mailboxId,
            doorDesign: letterData.doorDesign,
            colorDesign: letterData.colorDesign,
            decorationDesign: letterData.decorationDesign,
            content: letterData.content,
            font: letterData.font,
            visibility: letterData.visibility
        )
        
//        print("reply requestBody: \(requestBody)")
        
        LetterRequest.shared.editWrittenLetter(letterId: String(letterData.letterId), image: image, request: requestBody) {[weak self] result in
            switch result {
            case .success(let data):
                print("작성 성공")
//                print(data)
            case .failure(let error):
                let alert = NetworkAlert.shared.getAlertController(title: error.description)
                self?.present(alert, animated: true)
            }
        }
    }
    
    @objc
    private func openImagePicker() {
        self.present(self.picker, animated: true, completion: nil)
    }
    
    @objc
    private func touchUpInsideSendButton() {
        editLetterWithData()
        self.dismiss(animated: true)
    }
    
    @objc
    private func changeFontOption1() {
        rootView.textView.font = .customFont(font: .SejongGeulggot, ofSize: 15)
        rootView.placeholderLabel.font = .customFont(font: .SejongGeulggot, ofSize: 15)
        rootView.charCountLabel.font = .customFont(font: .SejongGeulggot, ofSize: 15)
        
        EditLetterData.shared.font = 1
        
        rootView.textView.layoutIfNeeded()
    }
    
    @objc
    private func changeFontOption2() {
        rootView.textView.font = .customFont(font: .KyoboHandWriting, ofSize: 15)
        rootView.placeholderLabel.font = .customFont(font: .KyoboHandWriting, ofSize: 15)
        rootView.charCountLabel.font = .customFont(font: .KyoboHandWriting, ofSize: 15)
        
        EditLetterData.shared.font = 2
        
        rootView.textView.layoutIfNeeded()
    }
    
    @objc
    private func changeFontOption3() {
        rootView.textView.font = .customFont(font: .GanwonEduLight, ofSize: 15)
        rootView.placeholderLabel.font = .customFont(font: .GanwonEduLight, ofSize: 15)
        rootView.charCountLabel.font = .customFont(font: .GanwonEduLight, ofSize: 15)
        
        EditLetterData.shared.font = 3
        
        rootView.textView.layoutIfNeeded()
    }
    
    @objc
    private func changeFontOption4() {
        rootView.textView.font = .customFont(font: .PretendardLight, ofSize: 15)
        rootView.placeholderLabel.font = .customFont(font: .PretendardLight, ofSize: 15)
        rootView.charCountLabel.font = .customFont(font: .PretendardLight, ofSize: 15)
        
        EditLetterData.shared.font = 4
        
        rootView.textView.layoutIfNeeded()
    }
    
    private func setNavigationBar(){
        // 뒤로 가기 버튼
        let leftBarButton = UIBarButtonItem(image: .popIcon, style: .plain, target: self, action: #selector(popAction))
        leftBarButton.tintColor = .blismBlack
        self.navigationItem.setLeftBarButton(leftBarButton, animated: true)
        
        // 타이틀
        self.navigationItem.titleView = NavigationTitleView(title: "답장하기", titleColor: .blismBlack)
    }
    
    @objc
    private func popAction(){
        dismiss(animated: true)
    }
}

extension EditLetterViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        rootView.placeholderLabel.isHidden = !textView.text.isEmpty
        let count = textView.text.count
        rootView.charCountLabel.text = "\(count)/150"
        
        if count > 150 {
            rootView.textView.text = String(rootView.textView.text.prefix(150))
            rootView.charCountLabel.text = "150/150"
        }
    }
}

extension EditLetterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.dismiss(animated: false, completion: {
                DispatchQueue.main.async {
                    self.rootView.imageAttachView.image = image
                }
            })
        }
    }
}

