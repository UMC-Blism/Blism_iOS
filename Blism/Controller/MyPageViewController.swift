//
//  MyPageViewController.swift
//  Blism
//
//  Created by 이수현 on 12/18/24.
//

import UIKit

public enum MyPageCellType : String{
    case receivedLetter = "내가 받은 답장"
    case sentReplyLetter = "내가 보낸 답장"
    case writingLetter = "내가 보낸 편지"
    case prevMailBox = "예전에 받은 우체통"
    case changeNickName = "닉네임(아이디) 변경"
}

class MyPageViewController : UIViewController {
    private let tableViewData : [MyPageCellType] = [
        .receivedLetter,
        .sentReplyLetter,
        .writingLetter,
        .prevMailBox,
        .changeNickName
    ]
    private let myPageView = MyPageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = myPageView
        setNavigationBar()
        setProtocol()
    }
    
    private func setProtocol(){
        myPageView.tableView.dataSource = self
        myPageView.tableView.delegate = self
    }
    
    private func setNavigationBar(){
        // 뒤로 가기 버튼
        let leftBarButton = UIBarButtonItem(image: .popIcon, style: .plain, target: self, action: #selector(popAction))
        leftBarButton.tintColor = .blismBlack
        self.navigationItem.setLeftBarButton(leftBarButton, animated: true)
        
        // 타이틀
        self.navigationItem.titleView = NavigationTitleView(title: "마이페이지", titleColor: .blismBlack)
    }
    
    @objc
    private func popAction(){
        self.navigationController?.popViewController(animated: true)
    }
}

extension MyPageViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyPageTableViewCell.id) as? MyPageTableViewCell else {
            return UITableViewCell()
        }
        cell.config(title: tableViewData[indexPath.section].rawValue)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    // 셀의 헤더 크기
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    // 헤더 셀
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView(frame: .zero)
    }
}


extension MyPageViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var nextVC = UIViewController()
        switch indexPath.section {
        case 0: nextVC = LetterListViewController(type: .receivedLetter)    // 내가 받은 답장
        case 1: nextVC = LetterListViewController(type: .sentReplyLetter)        // 내가 보낸 답장
        case 2: nextVC = LetterListViewController(type: .writingLetter)           // 내가 보낸 편지
        case 3:
            let dummyData = [
                ["2020", 10], ["2021", 20], ["2022", 30], ["2023", 15], ["2024", 23],
            ]
            nextVC = PrevMailBoxViewController(data: dummyData)    // 이전 메일함
        case 4: nextVC = CheckNicknameViewController()    // 닉네임 변경
        default : break
        }
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
