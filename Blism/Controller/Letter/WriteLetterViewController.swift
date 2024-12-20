//
//  WriteLetterViewController.swift
//  Blism
//
//  Created by 이재혁 on 12/18/24.
//

import UIKit



class WriteLetterViewController: UIViewController {

    private let writeView = WriteLetterView()
    private let picker = UIImagePickerController()
    var isReply: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = writeView
        
        setGesture()
        setImagePicker()
        setNavigationBar()
        setAction()
        setDelegate()
    }
    
    private func setGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openImagePicker))
        
        writeView.imageAttachView.addGestureRecognizer(tapGesture)
    }
    
    private func setImagePicker() {
        self.picker.sourceType = .photoLibrary
        self.picker.modalPresentationStyle = .fullScreen
    }
    
    private func setAction() {
        writeView.sendButton.addTarget(self, action: #selector(touchUpInsideSendButton), for: .touchUpInside)
        writeView.fontOption1Button.addTarget(self, action: #selector(changeFontOption1), for: .touchUpInside)
        writeView.fontOption2Button.addTarget(self, action: #selector(changeFontOption2), for: .touchUpInside)
        writeView.fontOption3Button.addTarget(self, action: #selector(changeFontOption3), for: .touchUpInside)
        writeView.fontOption4Button.addTarget(self, action: #selector(changeFontOption4), for: .touchUpInside)
    }
    
    private func setDelegate() {
        writeView.textView.delegate = self
        self.picker.delegate = self
    }
    
    private func setNavigationBar(){
        // 뒤로 가기 버튼
        let leftBarButton = UIBarButtonItem(image: .popIcon, style: .plain, target: self, action: #selector(popAction))
        leftBarButton.tintColor = .blismBlack
        self.navigationItem.setLeftBarButton(leftBarButton, animated: true)
        
        self.navigationItem.titleView = NavigationTitleView(title: "편지 작성하기", titleColor: .blismBlack)
    }
    
    @objc
    private func openImagePicker() {
        self.present(picker, animated: true, completion: nil)
    }
    
    @objc
    private func popAction(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc
    private func touchUpInsideSendButton() {
        if isReply {
            
        }
        else {
            let nextVC = SelectDoorDesignViewController()
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        
    }
    
    @objc
    private func changeFontOption1() {
        writeView.textView.font = .customFont(font: .SejongGeulggot, ofSize: 15)
        writeView.placeholderLabel.font = .customFont(font: .SejongGeulggot, ofSize: 15)
        writeView.charCountLabel.font = .customFont(font: .SejongGeulggot, ofSize: 15)
        
        writeView.textView.layoutIfNeeded()
    }
    
    @objc
    private func changeFontOption2() {
        writeView.textView.font = .customFont(font: .KyoboHandWriting, ofSize: 15)
        writeView.placeholderLabel.font = .customFont(font: .KyoboHandWriting, ofSize: 15)
        writeView.charCountLabel.font = .customFont(font: .KyoboHandWriting, ofSize: 15)
    }
    
    @objc
    private func changeFontOption3() {
        writeView.textView.font = .customFont(font: .GanwonEduLight, ofSize: 15)
        writeView.placeholderLabel.font = .customFont(font: .GanwonEduLight, ofSize: 15)
        writeView.charCountLabel.font = .customFont(font: .GanwonEduLight, ofSize: 15)
    }
    
    @objc
    private func changeFontOption4() {
        writeView.textView.font = .customFont(font: .PretendardLight, ofSize: 15)
        writeView.placeholderLabel.font = .customFont(font: .PretendardLight, ofSize: 15)
        writeView.charCountLabel.font = .customFont(font: .PretendardLight, ofSize: 15)
    }
}

extension WriteLetterViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        writeView.placeholderLabel.isHidden = !textView.text.isEmpty
        let count = textView.text.count
        writeView.charCountLabel.text = "\(count)/150"
        
        if count > 150 {
            writeView.textView.text = String(writeView.textView.text.prefix(150))
            writeView.charCountLabel.text = "150/150"
        }
    }
}

extension WriteLetterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.dismiss(animated: false, completion: {
                DispatchQueue.main.async {
                    self.writeView.imageAttachView.image = image
                }
            })
        }
    }
}
