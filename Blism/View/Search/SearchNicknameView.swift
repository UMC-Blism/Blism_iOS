//
//  SearchNicknameView.swift
//  Blism
//
//  Created by 이재혁 on 12/19/24.
//

import UIKit

class SearchNicknameView: UIView {

    // 백그라운드 이미지 뷰
    private let backgroundImageView = BackGroundImageView(type: .white)
    
    // 백 버튼
//    let backButton = UIButton().then {
//        $0.setImage(.popIcon, for: .normal)
//        $0.tintColor = .blismBlack
//    }
    
    // 텍스트필드 감싸는 뷰
    private let searchTextFieldGroupView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
    }
    
    // 닉네임 검색 텍스트필드
    let searchTextField = UITextField().then {
        let placeholderText = "닉네임을 입력해주세요."
        let placeholderColor = UIColor(hex: "#B1BCC5")
        let placeholderFont = UIFont.customFont(font: .PretendardLight, ofSize: 15)
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        $0.heightAnchor.constraint(equalToConstant: 20).isActive = true
        $0.leftView = leftView
        $0.leftViewMode = .always
        $0.attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: [
                .foregroundColor: placeholderColor,
                .font: placeholderFont
            ]
        )
        $0.font = .customFont(font: .PretendardLight, ofSize: 15)
        $0.textColor = .blismBlack
        $0.backgroundColor = .clear
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // 검색 버튼
    let searchButton = UIButton().then {
        $0.setImage(.searchBlue, for: .normal)
    }
    
    // 최근 검색한 우체통 라벨
    let recentSearchLabel = UILabel().then {
        $0.text = "최근 검색한 우체통"
        $0.font = .customFont(font: .PretendardLight, ofSize: 12)
        $0.textColor = UIColor(hex: "#575A61")
    }
    
    // 검색 기록 삭제하기 라벨
    let deleteSearchHistoryLabel = UILabel().then {
        $0.text = "검색 기록 삭제하기"
        $0.font = .customFont(font: .PretendardLight, ofSize: 12)
        $0.textColor = UIColor(hex: "#575A61")
    }
    
    // 검색 기록 테이블뷰
    let searchHistoryTableView = UITableView().then {
        $0.register(SearchHistoryTableViewCell.self, forCellReuseIdentifier: SearchHistoryTableViewCell.identifier)
        $0.separatorStyle = .singleLine
        $0.separatorColor = .clear
        //$0.separatorInset = .init(top: 0, left: 0, bottom: 18, right: 0)
        $0.allowsSelection = false
        $0.backgroundColor = .clear
        $0.isHidden = false
    }
    
    // 검색 결과 있을 때 테이블뷰
    let searchResultTableView = UITableView().then {
        $0.register(SearchResultTableViewCell.self, forCellReuseIdentifier: SearchResultTableViewCell.identifier)
        $0.separatorStyle = .singleLine
        $0.separatorColor = .clear
        //$0.separatorInset = .init(top: 0, left: 0, bottom: 20, right: 0)
        $0.isHidden = true
        $0.backgroundColor = .clear
    }
    
    // 검색 결과 없을 때 뷰
    let noResultView = NoResultView().then {
        $0.isHidden = true
        $0.backgroundColor = .clear
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubview()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubview() {
        [
            backgroundImageView,
//            backButton,
            searchTextFieldGroupView,
            recentSearchLabel,
            deleteSearchHistoryLabel,
            searchHistoryTableView,
            searchResultTableView,
            noResultView
        ].forEach { addSubview($0) }
        
        [
            searchTextField,
            searchButton
        ].forEach { searchTextFieldGroupView.addSubview($0) }
    }
    
    private func setConstraints() {
        searchTextField.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        searchButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-20)
            $0.width.height.equalTo(19)
        }
        
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
//        backButton.snp.makeConstraints {
//            $0.top.equalTo(safeAreaLayoutGuide).inset(20)
//            $0.leading.equalToSuperview().inset(16)
//            $0.width.equalTo(16)
//            $0.height.equalTo(32)
//        }
        
        searchTextFieldGroupView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(20)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(39)
        }
        
        recentSearchLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.top.equalTo(searchTextFieldGroupView.snp.bottom).offset(39)
        }
        
        deleteSearchHistoryLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(23)
            $0.centerY.equalTo(recentSearchLabel)
        }
        
        searchHistoryTableView.snp.makeConstraints {
            $0.top.equalTo(recentSearchLabel.snp.bottom).offset(39)
            $0.leading.equalTo(recentSearchLabel)
            $0.trailing.equalTo(deleteSearchHistoryLabel)
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
        }
        
        searchResultTableView.snp.makeConstraints {
            $0.top.equalTo(searchTextFieldGroupView.snp.bottom).offset(30)
            $0.leading.equalToSuperview().inset(17)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
        }
        
        noResultView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(searchTextFieldGroupView.snp.bottom).offset(60)
            $0.height.equalTo(195.01)
        }
    }
}
