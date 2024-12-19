//
//  PrevMailBoxViewController.swift
//  Blism
//
//  Created by 이수현 on 12/19/24.
//

import UIKit

class PrevMailBoxViewController: UIViewController {
    private let prevMailBoxView = PrevMailBoxView()
    
    private let dummyData = ["2020", "2021", "2022", "2023", "2021", "2022", "2023"]
    
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
        
        cell.config(year: dummyData[indexPath.row])
        return cell
    }
}

extension PrevMailBoxViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // API 연결
        let nextVC = PrevMailBoxDetailViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
