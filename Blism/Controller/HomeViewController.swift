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
    private let dummyData = MailBoxCollectionViewModel.Dummy()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = rootView
        rootView.doorCollectionView.dataSource = self
        rootView.doorCollectionView.delegate = self
        
//        navigationController?.setNavigationBarHidden(true, animated: true)
        let id = KeychainService.shared.load(account: .userInfo  , service: .id)
        nicknameChange(nickname: id!) //이부분은 로그인할때 받아옴
        tapRecognizer()
        
        
        viewController.modalPresentationStyle = .overFullScreen
//        viewController.view.backgroundColor = UIColor.black.withAlphaComponent(0.5) //투명도 50
        present(viewController, animated: false)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // 화면 이동 후 돌아올 때 뒤로가기 버튼이 나옴 '수정필요!'
        self.navigationItem.leftBarButtonItems = .none
        self.navigationController?.navigationBar.isHidden = true
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
        let viewController = SearchNicknameViewController()
        
        navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    @objc func goToMenu(){
        //nav 추가
        let nextVC = MyPageViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return MailBoxCollectionViewModel.Dummy().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let mailBoxCell = rootView.doorCollectionView.dequeueReusableCell(withReuseIdentifier: MailBoxCollectionViewCell.identifier, for: indexPath) as? MailBoxCollectionViewCell else {
            return UICollectionViewCell()
        }

        mailBoxCell.config(image: dummyData[indexPath.row].doorImage)
        
        return mailBoxCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let todayDate = Date()
        let calendar = Calendar.current
        
        // 오늘 날짜의 '일(day)' 추출
        let day = calendar.component(.day, from: todayDate)
        
        let readLetterPosibleDate = indexPath.row + 1
            
        if (day >= readLetterPosibleDate){
            
            let viewController = ReadLetterViewController(type: .home)
            
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
