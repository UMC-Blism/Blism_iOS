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
            // 배열 크기를 5로 제한
            if searchHistory.count > 5 {
                searchHistory.removeLast()
            }
            
            // 검색 기록 변경 시 UserDefaults에 저장
            UserDefaults.standard.set(searchHistory, forKey: "SearchHistory")
        }
    }

    func addSearchHistory(newSearchTerm: String) {
        // 이미 검색 기록에 해당 항목이 있으면 그 항목을 삭제
        if let index = searchHistory.firstIndex(of: newSearchTerm) {
            searchHistory.remove(at: index)
        }
        
        // 새 검색어를 배열의 첫 번째에 추가
        searchHistory.insert(newSearchTerm, at: 0)
        print(searchHistory)
        searchNicknameView.searchHistoryTableView.reloadData()
    }
    func resetSearchHistory() {
        // UserDefaults에서 검색 기록 삭제
        UserDefaults.standard.removeObject(forKey: "SearchHistory")
        
        // searchHistory 배열 초기화
        searchHistory = []
        
        // 테이블뷰 갱신 (필요한 경우)
        searchNicknameView.searchHistoryTableView.reloadData()
    }
    
    private var searchResult = [String]()

    private lazy var searchNicknameView = SearchNicknameView().then {
        $0.searchResultTableView.delegate = self
        $0.searchResultTableView.dataSource = self
        
        $0.searchHistoryTableView.delegate = self
        $0.searchHistoryTableView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view = searchNicknameView
        
        searchNicknameView.searchHistoryTableView.allowsSelection = true
        
        loadSearchHistory()
        setupAction()
        tapGesture()
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
    
    private func tapGesture(){
        self.searchNicknameView.deleteSearchHistoryLabel.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(deleteTapped))
        self.searchNicknameView.deleteSearchHistoryLabel.addGestureRecognizer(tapGesture)
    }
    @objc private func deleteTapped(){
        resetSearchHistory()
    }
    
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
        guard let searchNickname = searchNicknameView.searchTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !searchNickname.isEmpty else {
            // 빈칸일 경우 아무 동작 없음
            return
        }
        
        addSearchHistory(newSearchTerm: searchNickname)
        
        
        // search history tableview 업데이트
        searchNicknameView.searchHistoryTableView.reloadData()
        searchNicknameView.searchHistoryTableView.isHidden = true
        searchNicknameView.searchResultTableView.isHidden = false
        searchNicknameView.recentSearchLabel.isHidden = true
        searchNicknameView.noResultView.isHidden = true
        searchNicknameView.deleteSearchHistoryLabel.isHidden = true
        
        // API 연결
        self.searchAPI(searchNickname: searchNickname)
  
        
    }
    private func searchAPI(searchNickname: String) {
        let request = MemberSearchRequest(nickname: searchNickname)
        MemberAPI.shared.searchNickname(request: request) {[weak self] result in
            switch result {
            case .success(let data):
                // 배열이 비어있으면 -> 검색 결과가 없으면
                if data.result.isEmpty {
                    self?.searchNicknameView.noResultView.isHidden = false
                    self?.searchNicknameView.searchHistoryTableView.isHidden = true
                    self?.searchNicknameView.searchResultTableView.isHidden = true
                    self?.searchNicknameView.deleteSearchHistoryLabel.isHidden = true
                    self?.searchNicknameView.recentSearchLabel.isHidden = true
                } else {
                    self?.searchResult = data.result.map{$0.nickname}
                    self?.searchNicknameView.searchResultTableView.reloadData()
                }
            case .failure(let error):
                let alert = NetworkAlert.shared.getAlertController(title: error.description)
                self?.present(alert, animated: true)
            }
        }
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
            return searchResult.count
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
            
            if !searchResult.isEmpty {
                cell.nicknameLabel.text = searchResult[indexPath.section]
            }
            
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
            
        case searchNicknameView.searchHistoryTableView:
            // 선택된 검색 기록 가져오기
            let selectedHistory = searchHistory[indexPath.row]
            
            print(selectedHistory)
            // 검색 텍스트 필드에 값 설정
            searchNicknameView.searchTextField.text = selectedHistory
            searchNicknameView.searchTextField.layoutIfNeeded()
            
            // 검색 버튼 액션 호출
            searchButtonTapped()
            
        case searchNicknameView.searchResultTableView:
            let nextVC = VisitorCheckViewController(onwerNickname: searchResult[indexPath.section])
            self.navigationController?.pushViewController(nextVC, animated: true)
        default:
            return
        }
    }
}
