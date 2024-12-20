//
//  WriteLetterView.swift
//  Blism
//
//  Created by 이재혁 on 12/18/24.
//

import UIKit
import Then
import SnapKit

class WriteLetterView: UIView {
    // 백그라운드 이미지 뷰
    private let backgroundImageView = UIImageView().then {
        $0.image = .whiteBackground
        $0.contentMode = .scaleAspectFill
    }
    
    // 이미지 첨부 이미지뷰
    private let imageAttachView = UIImageView().then {
        $0.image = .attachPhoto
        $0.contentMode = .scaleAspectFill
        $0.isUserInteractionEnabled = true // 제스처 인식
    }
    
    // 폰트 옵션 그룹뷰
    private let fontOptionGroupView = UIView()
    
    // 폰트 옵션 라벨
    private let fontOptionLabel = UILabel().then {
        $0.text = "폰트 옵션"
        $0.font = .customFont(font: .PretendardLight, ofSize: 15)
        $0.textColor = .blismBlack
    }
    
    // 폰트 옵션 버튼들
    public let fontOption1Button: UIButton = createFontOptionButton(font: .customFont(font: .SejongGeulggot, ofSize: 15), title: "1번 폰트")
    public let fontOption2Button: UIButton = createFontOptionButton(font: .customFont(font: .KyoboHandWriting, ofSize: 15), title: "2번 폰트")
    public let fontOption3Button: UIButton = createFontOptionButton(font: .customFont(font: .GanwonEduLight, ofSize: 15), title: "3번 폰트")
    public let fontOption4Button: UIButton = createFontOptionButton(font: .customFont(font: .PretendardLight, ofSize: 14), title: "4번 폰트")
    
    // 받는 사람 그룹
    private let receiverGroupView: UIView = createSenderReceiverGroupView()
    
    private let receiverLabel = UILabel().then {
        $0.text = "To ."
        $0.font = .customFont(font: .PretendardLight, ofSize: 15)
        $0.textColor = UIColor(hex: "#1A274F")
    }
    
    private let receiverNameLabel = UILabel().then {
        $0.text = "받는 사람"
        $0.font = .customFont(font: .PretendardLight, ofSize: 15)
        $0.textColor = UIColor(hex: "#6C8FC6")
    }
    
    // 공개하기 토글 스위치
    private let toggleLabel = UILabel().then {
        $0.text = "이 편지를 잠그기"
        $0.font = .customFont(font: .PretendardLight, ofSize: 12)
        $0.textColor = UIColor(hex: "#1A274F")
    }
    
    private var toggleSwitch = UISwitch().then {
        $0.isOn = false
        $0.onTintColor = .blismBlue
    }
    
    // 편지 작성 텍스트뷰
    let textView = UITextView().then {
        $0.layer.borderColor = UIColor(hex: "#B7D2E5")?.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .white
        $0.clipsToBounds = false
        $0.isScrollEnabled = false
        $0.font = .customFont(font: .PretendardLight, ofSize: 15)
        $0.textContainerInset = UIEdgeInsets(top: 12, left: 10, bottom: 12, right: 12)
    }
    
    let placeholderLabel = UILabel().then {
        $0.text = "편지를 작성해 주세요."
        $0.textColor = UIColor(hex: "#6C8FC6")
        $0.font = .customFont(font: .PretendardLight, ofSize: 15)
    }
    
    let charCountLabel = UILabel().then {
        $0.text = "0/150"
        $0.textColor = UIColor(hex: "#6C8FC6")
        $0.font = .customFont(font: .PretendardLight, ofSize: 15)
    }
    
    // 보내는 사람 그룹
    private let senderGroupView: UIView = createSenderReceiverGroupView()
    
    private let senderLabel = UILabel().then {
        $0.text = "From ."
        $0.font = .customFont(font: .PretendardLight, ofSize: 15)
        $0.textColor = UIColor(hex: "#1A274F")
    }
    
    private let senderNameLabel = UILabel().then {
        $0.text = "보내는 사람"
        $0.font = .customFont(font: .PretendardLight, ofSize: 15)
        $0.textColor = UIColor(hex: "#6C8FC6")
    }
    
    let sendButton = UIButton().then {
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = UIColor(hex: "#6C8FC6")
        
        var titleAttr = AttributedString.init("메세지 등록하기")
        titleAttr.font = .systemFont(ofSize: 15, weight: UIFont.Weight(600))
        titleAttr.foregroundColor = .white
        
        configuration.attributedTitle = titleAttr
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.configuration = configuration
    }
    
    // 폰트 옵션 버튼 생성 함수
    private static func createFontOptionButton(font: UIFont, title: String) -> UIButton {
        let button = UIButton().then {
            var configuration = UIButton.Configuration.plain()
            var titleAttr = AttributedString(title)
            titleAttr.font = font
            
            configuration.attributedTitle = titleAttr
            configuration.baseForegroundColor = UIColor(hex: "#1A274F")
            configuration.background.strokeColor = UIColor(hex: "#B7D2E5")
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 7.5, leading: 0, bottom: 7.5, trailing: 0)
            
            $0.configuration = configuration
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        return button
    }

    private static func createSenderReceiverGroupView() -> UIView {
        let view = UIView().then {
            $0.layer.borderColor = UIColor(hex: "#B7D2E5")?.cgColor
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 10
            $0.backgroundColor = .white
        }
        
        return view
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubview()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubview() {
        [
            fontOptionLabel,
            fontOption1Button,
            fontOption2Button,
            fontOption3Button,
            fontOption4Button
        ].forEach { fontOptionGroupView.addSubview($0) } // 폰트 옵션 그룹
        
        [
            receiverLabel,
            receiverNameLabel
        ].forEach { receiverGroupView.addSubview($0) } // 받는 사람 그룹
        
        [
            senderLabel,
            senderNameLabel
        ].forEach { senderGroupView.addSubview($0) } // 보내는 사람 그룹
        
        [
            placeholderLabel
        ].forEach { textView.addSubview($0) }
        
        [
            backgroundImageView,
            imageAttachView,
            fontOptionGroupView,
            receiverGroupView,
            toggleLabel,
            toggleSwitch,
            textView,
            charCountLabel,
            senderGroupView,
            sendButton
        ].forEach { addSubview($0) }
    }
    
    private func setUI() {
        // 백그라운드 이미지
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        // 이미지 첨부 뷰
        imageAttachView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(45.5)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(319)
        }
        
        // 폰트 옵션 그룹 뷰
        fontOptionGroupView.snp.makeConstraints {
            $0.top.equalTo(imageAttachView.snp.bottom).offset(14)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(32)
        }
        
        // 폰트 옵션 라벨
        fontOptionLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(10)
        }
        
        // 폰트 옵션 버튼
        fontOption1Button.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(fontOptionLabel.snp.trailing).offset(17.75)
            $0.width.equalTo(60)
        }
        
        fontOption2Button.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(fontOption1Button.snp.trailing).offset(7.75)
            $0.width.equalTo(60)
        }
        
        fontOption3Button.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(fontOption2Button.snp.trailing).offset(7.75)
            $0.width.equalTo(60)
        }
        
        fontOption4Button.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(fontOption3Button.snp.trailing).offset(7.75)
            //$0.trailing.equalToSuperview()
            $0.width.equalTo(60)
        }
        
        // 받는 사람 그룹
        receiverGroupView.snp.makeConstraints {
            $0.top.equalTo(fontOptionGroupView.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(105)
            $0.height.equalTo(32)
        }
        
        receiverLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(7)
        }
        
        receiverNameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(receiverLabel.snp.trailing).offset(7)
        }
        
        // 토글
        toggleSwitch.snp.makeConstraints {
            $0.centerY.equalTo(receiverGroupView)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.equalTo(63)
            $0.height.equalTo(31)
        }
        
        toggleLabel.snp.makeConstraints {
            $0.centerY.equalTo(toggleSwitch)
            $0.trailing.equalTo(toggleSwitch.snp.leading).offset(-8)
        }
        
        // 텍스트뷰
        textView.snp.makeConstraints {
            $0.top.equalTo(receiverGroupView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(155)
        }
        
        placeholderLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(12)
        }
        
        charCountLabel.snp.makeConstraints {
            //$0.trailing.bottom.equalToSuperview().inset(15)
            $0.trailing.bottom.equalTo(textView).offset(-15)
        }
        
        // 보내는 사람 그룹
        senderGroupView.snp.makeConstraints {
            $0.top.equalTo(textView.snp.bottom).offset(10)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.equalTo(133)
            $0.height.equalTo(32)
        }
        
        senderLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(10)
        }
        
        senderNameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(senderLabel.snp.trailing).offset(3)
        }
        
        // 보내기 버튼
        sendButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(senderGroupView.snp.bottom).offset(32)
            $0.width.equalTo(128)
            $0.height.equalTo(45)
        }
    }
}
