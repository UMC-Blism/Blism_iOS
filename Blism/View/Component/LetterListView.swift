//
//  LetterListView.swift
//  Blism
//
//  Created by 이수현 on 12/19/24.
//

import UIKit

public enum LetterListType: String {
    case receivedLetter = "내가 받은 답장"
    case sentReplyLetter = "내가 보낸 답장"
    case writingLetter = "내가 보낸 편지"
}


class LetterListView : UIView {
    private let type : LetterListType
    
    // 배경 이미지
    private lazy var backgroundImage = BackGroundImageView(type: self.type == .receivedLetter ? .black : .white)
    
    // 테이블 뷰
    public let tableView = UITableView().then { view in
        view.register(LetterListTableViewCell.self, forCellReuseIdentifier: LetterListTableViewCell.id)
        view.separatorStyle = . none
        view.backgroundColor = .clear
        view.sectionHeaderTopPadding = 0
    }
    
    init(type : LetterListType){
        self.type = type
        super.init(frame: .zero)
        self.backgroundColor = .white
        
        setSubView()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubView(){
        [
            backgroundImage,
            tableView
        ].forEach{self.addSubview($0)}
    }
    
    private func setUI(){
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(30)
            make.horizontalEdges.bottom.equalToSuperview().inset(21)
        }
    }
}
