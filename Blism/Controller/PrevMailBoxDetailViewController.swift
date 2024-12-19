//
//  PrevMailBoxDetailViewController.swift
//  Blism
//
//  Created by 이수현 on 12/19/24.
//

import UIKit

class PrevMailBoxDetailViewController: UIViewController {
    private let prevMailBoxDetailView = PrevMailBoxDetailView()
    private let dummyData = MailBoxCollectionViewModel.Dummy()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = prevMailBoxDetailView
        
        setProtocol()
    }
    
    private func setProtocol(){
        prevMailBoxDetailView.collectionView.dataSource = self
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
