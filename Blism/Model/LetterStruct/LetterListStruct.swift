//
//  LetterListStruct.swift
//  Blism
//
//  Created by 이수현 on 12/22/24.
//

import Foundation

// 답장/편지 조회 데이터
// 답장 조회 데이터면 replyId 필수로 작성해야 함
public struct LetterData {
    let type: LetterListType
    let replyId: Int64?
    let letterId: Int64
    let dateString: String
    let content: String
    let receiver: String
    let sender: String
    let font: Int
}
