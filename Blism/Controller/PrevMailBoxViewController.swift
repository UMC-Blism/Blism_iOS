//
//  PrevMailBoxViewController.swift
//  Blism
//
//  Created by 이수현 on 12/19/24.
//

import UIKit

class PrevMailBoxViewController: UIViewController {
    private let prevMailBoxView = PrevMailBoxView()
    
    private let dummyData = [
        ["2020", 10], ["2021", 20], ["2022", 30], ["2023", 15], ["2024", 23],
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = prevMailBoxView
        
        setProtocol()
        setNavigationBar()
    }
    private func setProtocol(){
        prevMailBoxView.collectionView.dataSource = self
        prevMailBoxView.collectionView.delegate = self
    }
    
    private func setNavigationBar(){
        // 뒤로 가기 버튼
        let leftBarButton = UIBarButtonItem(image: .popIcon, style: .plain, target: self, action: #selector(popAction))
        leftBarButton.tintColor = .base2
        self.navigationItem.setLeftBarButton(leftBarButton, animated: true)
        
        // 타이틀
        self.navigationItem.titleView = NavigationTitleView(title: "에전에 받은 우체통", titleColor: .base2)
    }
    
    @objc
    private func popAction(){
        self.navigationController?.popViewController(animated: true)
    }
}

extension PrevMailBoxViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dummyData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PrevMailBoxCollectionViewCell.id, for: indexPath) as? PrevMailBoxCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.config(year: dummyData[indexPath.row][0] as? String ?? "")
        return cell
    }
}

extension PrevMailBoxViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // API 연결
        let year = dummyData[indexPath.row][0] as? String ?? ""
        let count = dummyData[indexPath.row][1] as? Int ?? 0
        let nextVC = PrevMailBoxDetailViewController(year: year, mailCount: count)
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
