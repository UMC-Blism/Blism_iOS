//
//  SelectDoorColorView.swift
//  Blism
//
//  Created by 이재혁 on 12/19/24.
//

import UIKit

class SelectDoorColorView: UIView {

    // 백그라운드 이미지 뷰
    private let backgroundImageView = BackGroundImageView(type: .white)
    
    // 설명 라벨
    private let descriptionLabel = UILabel().then {
        $0.text = "색상을 선택해주세요."
        $0.font = .customFont(font: .PretendardRegular, ofSize: 15)
        $0.textColor = .blismBlack
    }
    
    // 컬렉션 뷰 감쌀 프레임
    private let frameView = UIImageView().then {
        $0.image = .selectDesginFrame
        $0.contentMode = .scaleAspectFill
        $0.isUserInteractionEnabled = true
    }
    
    // 문 디자인 컬렉션 뷰
    let selectDoorColorCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.estimatedItemSize = .init(width: 111, height: 133)
        $0.minimumInteritemSpacing = 48
        $0.minimumLineSpacing = 23
    }).then {
        $0.backgroundColor = .clear
        $0.isScrollEnabled = false
        $0.isUserInteractionEnabled = true
        $0.allowsMultipleSelection = false
        $0.allowsSelection = true
        $0.register(DoorDesignCollectionViewCell.self, forCellWithReuseIdentifier: DoorDesignCollectionViewCell.identifier)
    }
    
    // 이전, 다음 버튼 그룹
    private let buttonGroupView = UIView()
    
    let previousButton = UIButton().then {
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = UIColor(hex: "#FFFFFF")
        
        var titleAttr = AttributedString.init("이전")
        titleAttr.font = .customFont(font: .PretendardSemiBold, ofSize: 15)
        titleAttr.foregroundColor = .blismBlack
        
        configuration.attributedTitle = titleAttr
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.configuration = configuration
    }
    
    let nextButton = UIButton().then {
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .blismBlue
        
        var titleAttr = AttributedString.init("다음")
        titleAttr.font = .customFont(font: .PretendardSemiBold, ofSize: 15)
        titleAttr.foregroundColor = .white
        
        configuration.attributedTitle = titleAttr
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.configuration = configuration
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
            backgroundImageView,
            descriptionLabel,
            frameView,
            buttonGroupView
        ].forEach { addSubview($0) }
        
        [
            selectDoorColorCollectionView
        ].forEach { frameView.addSubview($0) }
        
        [
            previousButton,
            nextButton
        ].forEach { buttonGroupView.addSubview($0) }
    }
    
    private func setUI() {
        selectDoorColorCollectionView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(270)
            $0.height.equalTo(289)
        }
        
        previousButton.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(128)
        }
        
        nextButton.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(128)
        }
        
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide).inset(UIApplication.shared.windows.first?.safeAreaInsets.top ?? 20 + 20)
        }
        
        frameView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(50)
            $0.height.equalTo(420)
        }
        
        buttonGroupView.snp.makeConstraints {
            $0.top.equalTo(frameView.snp.bottom).offset(43)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(313)
            $0.height.equalTo(45)
        }
    }


}
