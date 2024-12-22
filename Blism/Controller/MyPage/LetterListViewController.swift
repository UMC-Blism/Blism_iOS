//
//  LetterListViewController.swift
//  Blism
//
//  Created by 이수현 on 12/19/24.
//

import UIKit

class LetterListViewController : UIViewController {
    private let type : LetterListType
    private var letterListView : LetterListView
    private var letterListData : [LetterData] = []
    
    init(type : LetterListType) {
        self.type = type
        self.letterListView = LetterListView(type: type)
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = letterListView
        setProtocol()
        setNavigationBar()
        loadTableViewData()
    }
    
    private func loadTableViewData(){
        switch type {
        case .receivedReply:
            self.getReceivedReplyList()
        case .sentReply:
            self.getSentReplyList()
        case .writingLetter:
            self.getWritingLetterList()
        default: return
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setProtocol(){
        letterListView.tableView.dataSource = self
        letterListView.tableView.delegate = self
    }
    
    private func setNavigationBar(){
        // 뒤로 가기 버튼
        let leftBarButton = UIBarButtonItem(image: .popIcon, style: .plain, target: self, action: #selector(popAction))
        leftBarButton.tintColor = type == .receivedReply ? .base2 : .blismBlack
        self.navigationItem.setLeftBarButton(leftBarButton, animated: true)
        
        // 타이틀
        self.navigationItem.titleView = NavigationTitleView(title: type.rawValue, titleColor: type == .receivedReply ? .base2 : .blismBlack)
    }
    
    @objc
    private func popAction(){
        self.navigationController?.popViewController(animated: true)
    }
}

// API 함수
extension LetterListViewController {
    // 보낸 답장 리스트 가져오기
    private func getSentReplyList(){
        guard let myNickname = KeychainService.shared.load(account: .userInfo, service: .nickname) else {return}
        guard let memberId = KeychainService.shared.load(account: .userInfo, service: .memberId) else {
            print("getSentLetterList - 키체인 read 오류")
            return
        }
        guard let id = Int64(memberId) else {return}
        let request = ReadSentLetterListRequest(memberid: 8)
        ReplyAPI.shared.getSentLetterList(request: request) {[weak self] result in
            switch result {
            case .success(let responseData):
                if responseData.isSuccess {
                    if let data = responseData.result {
                        self?.letterListData = data.map{LetterData(type: .sentReply, replyId: $0.receiverId, letterId: $0.letterId, dateString: $0.createdDate, content: $0.content, receiver: $0.receiverName, sender: myNickname, font: $0.font)}
                        
                        self?.letterListView.tableView.reloadData()
                        
                    } else {
//                        데이터 없음
                        print("빈 데이터")
                    }
                } else {
                    let alert = NetworkAlert.shared.getAlertController(title: "서버 실패")
                    self?.present(alert, animated: true)
                }
            case .failure(let error):
                let alert = NetworkAlert.shared.getAlertController(title: error.description)
                self?.present(alert, animated: true)
            }
        }
    }
    
    // 받은 답장 리스트 가져오기
    private func getReceivedReplyList(){
        guard let myNickname = KeychainService.shared.load(account: .userInfo, service: .nickname) else {return}
        guard let memberId = KeychainService.shared.load(account: .userInfo, service: .memberId) else {
            print("getReceivedLetterList - 키체인 read 오류")
            return
        }
        guard let id = Int64(memberId) else {return}
        let request = ReadReceivedLetterListRequest(memberid: 7)
        ReplyAPI.shared.getReceivedLetterList(request: request) {[weak self] result in
            switch result {
            case .success(let responseData):
                if responseData.isSuccess {
                    if let data = responseData.result {
                        self?.letterListData = data.map{LetterData(type: .receivedReply, replyId: $0.replyId, letterId: $0.letterId, dateString: $0.createdDate, content: $0.content, receiver: myNickname, sender: $0.senderName, font: $0.font)}
                        self?.letterListView.tableView.reloadData()
                    } else {
//                        데이터 없음
                        print("빈 데이터")
                    }
                } else {
                    let alert = NetworkAlert.shared.getAlertController(title: "서버 실패")
                    self?.present(alert, animated: true)
                }
            case .failure(let error):
                let alert = NetworkAlert.shared.getAlertController(title: error.description)
                self?.present(alert, animated: true)
            }
        }
    }
    
    // 쓴 편지 리스트 가져오기
    private func getWritingLetterList(){
        guard let memberId = KeychainService.shared.load(account: .userInfo, service: .memberId) else {
            print("getSentLetterLsit - 키체인 read 오류")
            return
        }
        guard let id = Int64(memberId) else { return }
        let request = FetchSentLettersRequest(userId: id)
        LetterRequest.shared.fetchSentLetters(request: request) {[weak self]
            result in
            switch result {
            case .success(let responseData):
                if responseData.isSuccess {
                    if let data = responseData.result as [FetchSentLettersResponseData]? {
                        self?.letterListData = data.map {
                            LetterData(
                                type: .writingLetter,
                                replyId: nil,
                                letterId: $0.letterId,
                                dateString: self?.dateFormat(dateString: $0.createdAt) ?? "날짜 변환 실패",
                                content: $0.content,
                                receiver: $0.receiverNickname,
                                sender: $0.senderNickname,
                                font: $0.font
                            )
                        }
                        self?.letterListView.tableView.reloadData()
                    } else {
                        print("빈 데이터")
                    }
                } else {
                    let alert = NetworkAlert.shared.getAlertController(title: "서버 실패")
                    self?.present(alert, animated: true)
                }
            case .failure(let error):
                let alert = NetworkAlert.shared.getAlertController(title: error.description)
                self?.present(alert, animated: true)
            }
        }
    }
    
    private func dateFormat(dateString: String) -> String {
        let trimmedDateString = String(dateString.prefix(10)) // "2024-12-22"

        // DateFormatter로 변환
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)

        // 문자열 -> Date 변환
        if let date = dateFormatter.date(from: trimmedDateString) {
            // 변환된 Date를 원하는 형식으로 포맷팅
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "yyyy⋅MM⋅dd⋅EEE요일"
            outputFormatter.locale = Locale(identifier: "ko_KR") // 한국어 요일 표시
            let formattedDate = outputFormatter.string(from: date)
            //self.createdDate = formattedDate
            print(formattedDate) // 출력 예: "2024⋅12⋅22⋅일요일"
            return formattedDate
        } else {
            //self.createdDate = "날짜 변환 실패"
            return "날짜 변환 실패"
        }
    }
}

extension LetterListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LetterListTableViewCell.id) as? LetterListTableViewCell else {
            return UITableViewCell()
        }
        if !letterListData.isEmpty {
            cell.config(listInfo: letterListData[indexPath.section])
        }
            
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return letterListData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView(frame: .zero)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 19
    }
    
}


extension LetterListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 인덱스에 따라 연결
        
        let lettedId = letterListData[indexPath.section].letterId
        let replyId = letterListData[indexPath.section].replyId
        
        var nextVC = ReadLetterViewController(type: .receivedReply, letterId: lettedId)
        
        switch type {
        case .receivedReply: nextVC = ReadLetterViewController(type: .receivedReply, letterId: lettedId, replyId: replyId)
        case .sentReply: nextVC = ReadLetterViewController(type: .sentReply, letterId: lettedId, replyId: replyId)
        case .writingLetter: nextVC = ReadLetterViewController(type: .writingLetter, letterId: lettedId)
        default:
            return
        }
        nextVC.modalPresentationStyle = .overFullScreen
        present(nextVC, animated: false)   
    }
}

