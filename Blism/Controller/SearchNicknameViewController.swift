//
//  SearchNicknameViewController.swift
//  Blism
//
//  Created by 이재혁 on 12/19/24.
//

import UIKit

class SearchNicknameViewController: UIViewController {

    private lazy var searchNicknameView = SearchNicknameView().then {
        $0.searchResultTableView.delegate = self
        $0.searchResultTableView.dataSource = self
        
        $0.searchHistoryTableView.delegate = self
        $0.searchHistoryTableView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view = searchNicknameView
        self.navigationController?.isNavigationBarHidden = true
    }
    

}

extension SearchNicknameViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == searchNicknameView.searchHistoryTableView {
            return 4
        } else if tableView == searchNicknameView.searchResultTableView {
            return 1
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == searchNicknameView.searchResultTableView {
            return 2
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == searchNicknameView.searchHistoryTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchHistoryTableViewCell.identifier) as? SearchHistoryTableViewCell else { return UITableViewCell() }
            cell.historyNameLabel.text = "햄"
            
            return cell
        } else if tableView == searchNicknameView.searchResultTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.identifier) as? SearchResultTableViewCell else { return UITableViewCell() }
            cell.nicknameLabel.text = "햄"
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == searchNicknameView.searchHistoryTableView {
            return 36
        } else if tableView == searchNicknameView.searchResultTableView {
            return 50
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if tableView == searchNicknameView.searchResultTableView {
            return 20
        }
        return 0
    }
}
