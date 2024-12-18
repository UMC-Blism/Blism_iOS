//
//  LetterListViewController.swift
//  Blism
//
//  Created by 이수현 on 12/19/24.
//

import UIKit

class LetterListViewController : UIViewController {
    private let type : LetterListType
    private let letterListView : LetterListView
    
    init(type : LetterListType) {
        self.type = type
        self.letterListView = LetterListView(type: type)
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setProtocol()
        view = letterListView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setProtocol(){
        letterListView.tableView.dataSource = self
        letterListView.tableView.delegate = self
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
        cell.config(type: type)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
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
    
}
