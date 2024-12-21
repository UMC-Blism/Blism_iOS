//
//  ReplyLetterViewController.swift
//  Blism
//
//  Created by 송재곤 on 12/19/24.
//

import UIKit



class ReplyLetterViewController: UIViewController {
    
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
        
        rootView.placeholderLabel.text = "답장을 작성해 주세요."
        rootView.sendButton.setTitle("답장 저장", for: .normal)
        rootView.toggleLabel.isHidden = true
        rootView.toggleSwitch.isHidden = true
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
    
    @objc
    private func openImagePicker() {
        self.present(self.picker, animated: true, completion: nil)
    }
    
    @objc
    private func touchUpInsideSendButton() {
        self.dismiss(animated: true)
    }
    
    @objc
    private func changeFontOption1() {
        rootView.textView.font = .customFont(font: .SejongGeulggot, ofSize: 15)
        rootView.placeholderLabel.font = .customFont(font: .SejongGeulggot, ofSize: 15)
        rootView.charCountLabel.font = .customFont(font: .SejongGeulggot, ofSize: 15)
        
        rootView.textView.layoutIfNeeded()
    }
    
    @objc
    private func changeFontOption2() {
        rootView.textView.font = .customFont(font: .KyoboHandWriting, ofSize: 15)
        rootView.placeholderLabel.font = .customFont(font: .KyoboHandWriting, ofSize: 15)
        rootView.charCountLabel.font = .customFont(font: .KyoboHandWriting, ofSize: 15)
    }
    
    @objc
    private func changeFontOption3() {
        rootView.textView.font = .customFont(font: .GanwonEduLight, ofSize: 15)
        rootView.placeholderLabel.font = .customFont(font: .GanwonEduLight, ofSize: 15)
        rootView.charCountLabel.font = .customFont(font: .GanwonEduLight, ofSize: 15)
    }
    
    @objc
    private func changeFontOption4() {
        rootView.textView.font = .customFont(font: .PretendardLight, ofSize: 15)
        rootView.placeholderLabel.font = .customFont(font: .PretendardLight, ofSize: 15)
        rootView.charCountLabel.font = .customFont(font: .PretendardLight, ofSize: 15)
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

extension ReplyLetterViewController: UITextViewDelegate {
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

extension ReplyLetterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
