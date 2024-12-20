//
//  SearchNicknameViewController.swift
//  Blism
//
//  Created by 이재혁 on 12/19/24.
//

import UIKit

class SearchNicknameViewController: UIViewController {
    
    private var searchHistory: [String] = [] {
        didSet {
            // 검색 기록 변경 시 UserDefaults 저장
            UserDefaults.standard.set(searchHistory, forKey: "SearchHistory")
        }
    }

    private lazy var searchNicknameView = SearchNicknameView().then {
        $0.searchResultTableView.delegate = self
        $0.searchResultTableView.dataSource = self
        
        $0.searchHistoryTableView.delegate = self
        $0.searchHistoryTableView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view = searchNicknameView
        
        loadSearchHistory()
        setupAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        
        searchNicknameView.searchHistoryTableView.isHidden = false
        searchNicknameView.searchResultTableView.isHidden = true
        searchNicknameView.recentSearchLabel.isHidden = false
        searchNicknameView.noResultView.isHidden = true
        searchNicknameView.deleteSearchHistoryLabel.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }

    private func setupAction() {
        searchNicknameView.searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
//        searchNicknameView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
//    @objc
//    private func backButtonTapped() {
//        self.navigationController?.popViewController(animated: true)
//    }
    
    private func loadSearchHistory() {
        if let savedHistory = UserDefaults.standard.array(forKey: "SearchHistory") as? [String] {
            searchHistory = savedHistory
        }
    }
    
    @objc
    private func searchButtonTapped() {
//        if searchNicknameView.searchTextField.text?.isEmpty ?? true {
//            searchNicknameView.searchHistoryTableView.isHidden = true
//            searchNicknameView.searchResultTableView.isHidden = true
//            searchNicknameView.noResultView.isHidden = false
//            searchNicknameView.recentSearchLabel.isHidden = true
//            searchNicknameView.deleteSearchHistoryLabel.isHidden = true
//        } else {
//            searchNicknameView.searchHistoryTableView.isHidden = true
//            searchNicknameView.searchResultTableView.isHidden = false
//            searchNicknameView.recentSearchLabel.isHidden = true
//            searchNicknameView.noResultView.isHidden = true
//            searchNicknameView.deleteSearchHistoryLabel.isHidden = true
//        }
        guard let text = searchNicknameView.searchTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !text.isEmpty else {
            // 빈칸일 경우 아무 동작 없음
            return
        }
        
        // 필드 빈칸 아닐 때
        searchHistory.append(text)
        searchNicknameView.searchTextField.text = ""
        
        // search history tableview 업데이트
        searchNicknameView.searchHistoryTableView.reloadData()
        searchNicknameView.searchHistoryTableView.isHidden = true
        searchNicknameView.searchResultTableView.isHidden = false
        searchNicknameView.recentSearchLabel.isHidden = true
        searchNicknameView.noResultView.isHidden = true
        searchNicknameView.deleteSearchHistoryLabel.isHidden = true
        
    }
}

extension SearchNicknameViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == searchNicknameView.searchHistoryTableView {
            return searchHistory.count
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
            cell.historyNameLabel.text = searchHistory[indexPath.row]
            cell.deleteButton.tag = indexPath.row
            cell.deleteButton.addTarget(self, action: #selector(deleteHistoryItem(_:)), for: .touchUpInside)
            
            return cell
        } else if tableView == searchNicknameView.searchResultTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.identifier) as? SearchResultTableViewCell else { return UITableViewCell() }
            cell.nicknameLabel.text = "햄"
            
            return cell
        }
        return UITableViewCell()
        
    }
    
    @objc
    private func deleteHistoryItem(_ sender: UIButton) {
        let index = sender.tag
        searchHistory.remove(at: index)
        searchNicknameView.searchHistoryTableView.reloadData()
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

extension SearchNicknameViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case searchNicknameView.searchResultTableView:
            let nextVC = VisiterCheckViewController()
            self.navigationController?.pushViewController(nextVC, animated: true)
        default:
            return
        }
    }
}
