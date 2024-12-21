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
    private var letterListData : [LetterListInfo] = []
    
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
        case .receivedLetter:
            self.getReceivedLetterList()
        case .sentReplyLetter:
            self.getReceivedLetterList()
        case .writingLetter:
            self.getReceivedLetterList()
        case .home:
            self.getReceivedLetterList()
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
        leftBarButton.tintColor = type == .receivedLetter ? .base2 : .blismBlack
        self.navigationItem.setLeftBarButton(leftBarButton, animated: true)
        
        // 타이틀
        self.navigationItem.titleView = NavigationTitleView(title: type.rawValue, titleColor: type == .receivedLetter ? .base2 : .blismBlack)
    }
    
    @objc
    private func popAction(){
        self.navigationController?.popViewController(animated: true)
    }
    
    // 받은 편지 리스트 가져오기
    private func getReceivedLetterList(){
        guard let myNickname = KeychainService.shared.load(account: .userInfo, service: .nickname) else {return}
        guard let memberId = KeychainService.shared.load(account: .userInfo, service: .memberId) else {
            print("fetchAPI - 키체인 read 오류")
            return
        }
        guard let id = Int64(memberId) else {return}
        let reqeust = ReadReceivedLetterListRequest(memberid: id)
        ReplyAPI.shared.getReceivedLetterList(request: reqeust) {[weak self] result in
            switch result {
            case .success(let responseData):
                if responseData.isSuccess {
                    if let data = responseData.result {
                        self?.letterListData = data.map{LetterListInfo(type: .receivedLetter, dateString: $0.createdDate, content: $0.content, receiver: myNickname, sender: $0.senderName)}
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
        
        var nextVC = ReadLetterViewController(type: .receivedLetter)
        
        switch type {
        case .receivedLetter: nextVC = ReadLetterViewController(type: .receivedLetter)
        case .sentReplyLetter: nextVC = ReadLetterViewController(type: .sentReplyLetter)
        case .writingLetter: nextVC = ReadLetterViewController(type: .writingLetter)
        default:
            return
        }
        nextVC.modalPresentationStyle = .overFullScreen
        present(nextVC, animated: false)
        
    }
}
