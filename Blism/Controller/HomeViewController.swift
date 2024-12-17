//
//  ViewController.swift
//  Blism
//
//  Created by 이수현 on 12/16/24.
//

import UIKit

class HomeViewController: UIViewController {

    private let rootView = HomeView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = rootView
        rootView.doorCollectionView.dataSource = self
    }


}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return MailBoxCollectionViewModel.Dummy().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let MailBoxCell = rootView.doorCollectionView.dequeueReusableCell(withReuseIdentifier: MailBoxCollectionViewCell.identifier, for: indexPath) as? MailBoxCollectionViewCell else {
            return UICollectionViewCell()
        }
        let Dummy = MailBoxCollectionViewModel.Dummy()
        MailBoxCell.doorImage.image = Dummy[indexPath.row].doorImage
        
        return MailBoxCell
    }
    
    
   
}
