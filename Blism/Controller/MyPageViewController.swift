//
//  MyPageViewController.swift
//  Blism
//
//  Created by 이수현 on 12/18/24.
//

import UIKit

class MyPageViewController : UIViewController {
    private let tableViewData = ["내가 보낸 답장", "내가 받은 답장", "내가 쓴 글", "예전에 받은 우체통", "닉네임 (아이디) 변경"]
    private let myPageView = MyPageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = myPageView
        
        setProtocol()
    }
    
    private func setProtocol(){
        myPageView.tableView.dataSource = self
        myPageView.tableView.delegate = self
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
        cell.config(title: tableViewData[indexPath.section])
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
    
}
