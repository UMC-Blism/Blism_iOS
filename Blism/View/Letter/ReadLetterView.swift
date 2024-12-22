//
//  LetterView.swift
//  Blism
//
//  Created by 송재곤 on 12/17/24.
//

import UIKit
import Kingfisher

class ReadLetterView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupComponent()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public let backgroundImageView: UIImageView = {
        let image = UIImageView()
        
        image.image = UIImage(named: "whiteBackground")
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        
        return image
    }()
    
    public let ImageViewExample: UIImageView = {
        let image = UIImageView()
        
        image.image = UIImage(named: "readExample")
        image.layer.cornerRadius = 10
        return image
    }()
    
    public var whenLetterWrite: UILabel = {
        let label = UILabel()
        
        label.text = "2024·12·26·목요일"
        label.font = .systemFont(ofSize: 12, weight: .regular)
        
        return label
    }()
    
    public var letterReceiver : PaddingLabel = {
        let label = PaddingLabel()
        
        label.text = "To . 받는 사람"
        
        label.textColor = UIColor.blismBlack
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.layer.cornerRadius = 10
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.backgroundColor = .white
        label.layer.masksToBounds = true
        
        return label
    }()
    
    public var letterContent : PaddingLabel = {
        let label = PaddingLabel() // 커스텀 패딩을 전달
        
        label.text = "편지내용이 들어갑니다편지내용이 들어갑니다.편지내용이 들어갑니다.편지내용이 들어갑니다.편지내용이 들어갑니다편지내용이 들어갑니다.편지내용이 들어갑니다.편지내용이 들어갑니다.편지내용이 들어갑니다편지내용이 들어갑니다.편지내용이 들어갑니다.편지내용이 들어갑니다.편지내용이 들어 "
        
        label.textColor = UIColor.blismBlue
        label.font = .customFont(font: .SejongGeulggot, ofSize: 15)
        label.layer.cornerRadius = 10
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.numberOfLines = 0
        label.backgroundColor = .white
        label.layer.masksToBounds = true
        label.lineBreakMode = .byCharWrapping
        
        return label
    }()
    
    public var letterSender : PaddingLabel = {
        let label = PaddingLabel()
        
        label.text = "From . 보내는 사람"
        
        label.textColor = UIColor.blismBlack
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.layer.cornerRadius = 10
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.backgroundColor = .white
        label.layer.masksToBounds = true
        
        return label
    }()

    public lazy var replyButton: UIButton = {
        
        let btn = UIButton()
        
        btn.setTitle("답장하기", for: .normal)
        btn.titleLabel?.font = .customFont(font: .PretendardRegular, ofSize: 15)
        btn.backgroundColor = UIColor.blismBlue
        btn.titleLabel?.textColor = .white
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        
        return btn
    }()
    
    public lazy var backButton: UIButton = {
        
        let btn = UIButton()
        
        btn.setTitle("이전", for: .normal)
        btn.setTitleColor(.blismBlack, for: .normal)
        btn.titleLabel?.font = .customFont(font: .PretendardRegular, ofSize: 15)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        
        return btn
    }()
    
    func setupComponent(){
        addSubview(backgroundImageView)
        addSubview(ImageViewExample)
        addSubview(letterSender)
        addSubview(letterContent)
        addSubview(letterReceiver)
        addSubview(whenLetterWrite)
        addSubview(replyButton)
        addSubview(backButton)
        
        backgroundImageView.snp.makeConstraints{
            $0.top.equalTo(safeAreaLayoutGuide).offset(45)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(684)
            $0.width.equalTo(343)
        }
        ImageViewExample.snp.makeConstraints{
            $0.width.height.equalTo(280)
            $0.top.equalTo(backgroundImageView.snp.top).offset(49)
            $0.centerX.equalTo(backgroundImageView.snp.centerX)
        }
        whenLetterWrite.snp.makeConstraints{
            $0.top.equalTo(backgroundImageView.snp.top).offset(22)
            $0.leading.equalTo(backgroundImageView.snp.leading).offset(47)
        }
        letterReceiver.snp.makeConstraints{
            $0.top.equalTo(ImageViewExample.snp.bottom).offset(20)
            $0.leading.equalTo(ImageViewExample.snp.leading)
            $0.width.equalTo(105)
            $0.height.equalTo(32)
        }
        letterContent.snp.makeConstraints{
            $0.top.equalTo(letterReceiver.snp.bottom).offset(10)
            $0.leading.equalTo(ImageViewExample.snp.leading)
            $0.width.equalTo(286)
            $0.height.equalTo(155)
        }
        letterSender.snp.makeConstraints{
            $0.top.equalTo(letterContent.snp.bottom).offset(10)
            $0.trailing.equalTo(letterContent.snp.trailing)
        }
        replyButton.snp.makeConstraints{
            $0.top.equalTo(letterSender.snp.bottom).offset(20)
            $0.trailing.equalTo(letterSender.snp.trailing)
            $0.width.equalTo(128)
            $0.height.equalTo(45)
        }
        
        backButton.snp.makeConstraints{
            $0.top.equalTo(letterSender.snp.bottom).offset(20)
            $0.leading.equalTo(letterContent.snp.leading)
            $0.width.equalTo(128)
            $0.height.equalTo(45)
        }
    }
    
    public func setButton(type: LetterListType){
        switch type {
        case .receivedLetter:
            replyButton.isHidden = true
        case .sentReplyLetter:
            replyButton.isHidden = true
        case .writingLetter:
            replyButton.setTitle("수정하기", for: .normal)
        case .home:
            backButton.isHidden = true
        }
    }
    
    public func config(letterInfo: ReadLetterResponseData) {
        ImageViewExample.kf.setImage(with: URL(string: letterInfo.photoUrl), placeholder: UIImage.readExample)
        letterSender.text = "From. \(letterInfo.senderNickname)"
        letterReceiver.text = "To. \(letterInfo.receiverNickname)"
        letterContent.text = letterInfo.content
        
        // 날짜 추가해야 함 (ReadLetterResponse)
        
        switch letterInfo.font {
        case 1:
            letterContent.font = .customFont(font: .SejongGeulggot, ofSize: 15)
        case 2:
            letterContent.font = .customFont(font: .KyoboHandWriting, ofSize: 15)
        case 3:
            letterContent.font = .customFont(font: .GanwonEduLight, ofSize: 15)
        case 4:
            letterContent.font = .customFont(font: .PretendardLight, ofSize: 15)
        default:
            break
        }
    }
}
