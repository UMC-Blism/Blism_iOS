//
//  PrevMailBoxDetailViewController.swift
//  Blism
//
//  Created by 이수현 on 12/19/24.
//

import UIKit

class PrevMailBoxDetailViewController: UIViewController {
    private let prevMailBoxDetailView: PrevMailBoxDetailView
    private let dummyData = MailBoxCollectionViewModel.Dummy()
    private let year: String
    
    init(year: String, mailCount: Int) {
        self.year = year
        self.prevMailBoxDetailView = PrevMailBoxDetailView(year: year, count: mailCount)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = prevMailBoxDetailView
        
        setProtocol()
        setNavigationBar()
    }
    
    private func setProtocol(){
        prevMailBoxDetailView.collectionView.dataSource = self
    }
    
    private func setNavigationBar(){
        // 뒤로 가기 버튼
        let leftBarButton = UIBarButtonItem(image: .popIcon, style: .plain, target: self, action: #selector(popAction))
        leftBarButton.tintColor = .base2
        self.navigationItem.setLeftBarButton(leftBarButton, animated: true)
        
        // 타이틀
        let title = "\(year)년에 받은 우체통"
        self.navigationItem.titleView = NavigationTitleView(title: title, titleColor: .base2)
    }
    
    @objc
    private func popAction(){
        self.navigationController?.popViewController(animated: true)
    }
}


extension PrevMailBoxDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummyData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MailBoxCollectionViewCell.identifier, for: indexPath) as? MailBoxCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.config(image: dummyData[indexPath.row].doorImage)
        return cell
    }
}
