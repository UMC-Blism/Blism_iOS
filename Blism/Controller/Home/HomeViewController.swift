//
//  ViewController.swift
//  Blism
//
//  Created by 이수현 on 12/16/24.
//

import UIKit
import Moya

class HomeViewController: UIViewController {
    private let rootView = HomeView()
    let viewController = HomeDisclosureViewController()
    private let dummyData = MailBoxCollectionViewModel.Dummy()
    
    //API 연결
    var homeInfoResponse : MailBoxResponse?
    private let apiService = HomeMailBoxRequest()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = rootView
        rootView.doorCollectionView.dataSource = self
        rootView.doorCollectionView.delegate = self
        
        //        navigationController?.setNavigationBarHidden(true, animated: true)
        let id = KeychainService.shared.load(account: .userInfo  , service: .id)
        nicknameChange(nickname: id!) //이부분은 로그인할때 받아옴
        let numberOfMail = String(homeInfoResponse?.data.count ?? 0)
        numOfMailChange(num: numberOfMail)
        
        
        viewController.modalPresentationStyle = .overFullScreen
        //        viewController.view.backgroundColor = UIColor.black.withAlphaComponent(0.5) //투명도 50
        present(viewController, animated: false)
        
        // API 호출
        fetchMailBoxInfo(userId: id!)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // API 호출 함수
    private func fetchMailBoxInfo(userId: String) {
        let IntId = Int(userId)
        apiService.fetchMyMailBoxInfo(userId: IntId ?? 0) { [weak self] result in
                self?.homeInfoResponse = result
                print("success")
        }
    }
    
    
    func nicknameChange(nickname: String){
        let updatedText = rootView.mailboxOwner.text?.replacingOccurrences(of: "지수", with: nickname)
        rootView.mailboxOwner.text = updatedText
    }
    func numOfMailChange(num: String){
        
        let updatedText = rootView.mailboxOwner.text?.replacingOccurrences(of: "n", with: num)
        
        rootView.numberOfMail.text = updatedText
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
            viewController.modalPresentationStyle = .overFullScreen
            present(viewController, animated: false)
        }else{
            
            let viewController = HomeDateAlertViewController()
            
            viewController.readLetterPosibleDateReceiver = readLetterPosibleDate
            viewController.modalPresentationStyle = .overFullScreen
            present(viewController, animated: false)
            

        }
        
    }
   
}
