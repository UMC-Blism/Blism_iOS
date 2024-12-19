//
//  ViewController.swift
//  Blism
//
//  Created by 이수현 on 12/16/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let rootView = HomeView()
    let viewController = HomeDisclosureViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = rootView
        rootView.doorCollectionView.dataSource = self
        rootView.doorCollectionView.delegate = self
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        nicknameChange(nickname: "아진") //이부분은 로그인할때 받아옴
        tapRecognizer()
        
        
        viewController.modalPresentationStyle = .overFullScreen
//        viewController.view.backgroundColor = UIColor.black.withAlphaComponent(0.5) //투명도 50
        present(viewController, animated: false)
        
    }
    

    
    func nicknameChange(nickname: String){
        
        let updatedText = rootView.mailboxOwner.text?.replacingOccurrences(of: "지수", with: nickname)
        
        rootView.mailboxOwner.text = updatedText
    }
    
    func tapRecognizer(){
        let searchTapGesture = UITapGestureRecognizer(target: self, action: #selector(goToSearch))
        rootView.searchButton.addGestureRecognizer(searchTapGesture)
        rootView.searchButton.isUserInteractionEnabled = true
        
        let menuTapGesture = UITapGestureRecognizer(target: self, action: #selector(goToMenu))
        rootView.menuButton.addGestureRecognizer(menuTapGesture)
        rootView.menuButton.isUserInteractionEnabled = true
    }
    
    @objc func goToSearch(){
        //nav 추가
        print("검색")
        let viewController = VisiterHomeViewController()
        
        navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    @objc func goToMenu(){
        //nav 추가
        print("메뉴")
    }
    
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let todayDate = Date()
        let calendar = Calendar.current
        
        // 오늘 날짜의 '일(day)' 추출
        let day = calendar.component(.day, from: todayDate)
        
        let readLetterPosibleDate = indexPath.row + 1
            
        if (day >= readLetterPosibleDate){
            
            let viewController = ReadLetterViewController()
            
//            viewController.view.backgroundColor = UIColor.black.withAlphaComponent(0.5) //투명도 50
            viewController.modalPresentationStyle = .overFullScreen
            present(viewController, animated: false)
        }else{
            
            let viewController = HomeDateAlertViewController()
            
            viewController.readLetterPosibleDateReceiver = readLetterPosibleDate
//            viewController.view.backgroundColor = UIColor.black.withAlphaComponent(0.5) //투명도 50
            viewController.modalPresentationStyle = .overFullScreen
            present(viewController, animated: false)
            

        }
        
    }
   
}
