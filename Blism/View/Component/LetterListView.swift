//
//  LetterListView.swift
//  Blism
//
//  Created by 이수현 on 12/19/24.
//

import UIKit

public enum LetterListType {
    case receivedLetter // 내가 받은 답변
    case sentLetter   // 내가 쓴 답변
    case writing     // 내가 쓴 글
}


class LetterListView : UIView {
    private let type : LetterListType
    
    // 배경 이미지
    private lazy var backgroundImage = BackGroundImageView(type: self.type == .receivedLetter ? .black : .white)
    
    // 테이블 뷰
    public let tableView = UITableView()
    
    init(type : LetterListType){
        self.type = type
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
