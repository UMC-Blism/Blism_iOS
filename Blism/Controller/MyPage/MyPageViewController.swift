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
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        
        // 닉네임, 날짜 데이터 적용
        self.setUserInfo()
        
    }
    
    private func setProtocol(){
        myPageView.tableView.dataSource = self
        myPageView.tableView.delegate = self
    }
    
    private func setNavigationBar(){
        // 타이틀
        self.navigationItem.titleView = NavigationTitleView(title: "마이페이지", titleColor: .blismBlack)
    }
    
    // 닉네임, 날짜 데이터 적용
    private func setUserInfo(){
        let myNickname = KeychainService.shared.load(account: .userInfo, service: .nickname) ?? "---"    
        let dDayString = daysUntilDecemberFirst()
    
        myPageView.setUserInfo(nickname: myNickname, dDay: dDayString)
    }
    
    // D-Day 계산 함수
    private func daysUntilDecemberFirst() -> String {
        let calendar = Calendar.current
        let today = Date()

        // 현재 연도의 12월 1일 설정
        let currentYear = calendar.component(.year, from: today)
        var dateComponents = DateComponents()
        dateComponents.year = currentYear
        dateComponents.month = 12
        dateComponents.day = 1

        // 목표 날짜 생성
        guard let targetDate = calendar.date(from: dateComponents) else {
            return "날짜 계산 오류"
        }

        // 오늘과 목표 날짜 간의 차이 계산 (남은 날짜)
        let remainingDays = calendar.dateComponents([.day], from: today, to: targetDate).day ?? 0
        
        // 오늘과 목표 날짜 간의 차이 계산 (지난 날짜)
        let afterDays = calendar.dateComponents([.day], from: targetDate, to: today).day ?? 0

        return remainingDays >= 0 ? "D-\(remainingDays)일" : "D+\(afterDays)일"
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
        case 3: nextVC = PrevMailBoxViewController()     // 이전 메일함
        case 4: nextVC = CheckNicknameViewController()    // 닉네임 변경
        default : break
        }
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
