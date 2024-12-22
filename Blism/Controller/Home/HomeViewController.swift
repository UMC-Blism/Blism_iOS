//
//  ViewController.swift
//  Blism
//
//  Created by 이수현 on 12/16/24.
//

import UIKit
import Moya
import Kingfisher

class HomeViewController: UIViewController {
    private let rootView = HomeView()
    let viewController = HomeDisclosureViewController()
    
    //API 연결
    var homeInfoResponse : MailboxCheckingResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = rootView
        rootView.doorCollectionView.dataSource = self
        rootView.doorCollectionView.delegate = self
        
        viewController.modalPresentationStyle = .overFullScreen
        present(viewController, animated: false)
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("homeVC -viewWIllAppear")
        self.navigationController?.navigationBar.isHidden = true
        
        // API 호출
        let nickname = KeychainService.shared.load(account: .userInfo  , service: .nickname) ?? "닉네임 오류"
        nicknameChange(nickname: nickname) //이부분은 로그인할때 받아옴
        
        // 키체인 불러오기
        if let memberId = KeychainService.shared.load(account: .userInfo, service: .memberId), let nickname = KeychainService.shared.load(account: .userInfo, service: .nickname) {
            
            
        fetchMailBoxInfo(userId: memberId)
        nicknameChange(nickname: nickname)
            
        } else {
            // 아이디 없음 오류
            print("HomeVieController - 키체인 저장된 멤버 아이디 없음")
        }
    }
    
    // API 호출 함수
    private func fetchMailBoxInfo(userId: String) {
        guard let memberId = Int64(userId) else {return}
        
        let request = MailboxCheckingRequest(memberId: memberId)
        MailboxAPI.shared.mailboxCheck(request: request) {[weak self] result in
            switch result {
            case .success(let data):
                print("\(data)**")
                if data.isSuccess {
                    self?.homeInfoResponse = data
                    
                    let numberOfMail = String(self?.homeInfoResponse?.result?.count ?? 1)
                    print("&&&& \(self?.homeInfoResponse?.result?.count)")
                    self?.numOfMailChange(num: numberOfMail)
                    self?.rootView.doorCollectionView.reloadData()
                } else {
                    print("data isFailed")
                }
                
            case .failure(let error):
                let alert = NetworkAlert.shared.getAlertController(title: error.description)
                self?.present(alert, animated: true)
            }
        }
    }
    
    
    func nicknameChange(nickname: String){
        let updatedText = rootView.mailboxOwner.text?.replacingOccurrences(of: "지수", with: nickname)
        rootView.mailboxOwner.text = updatedText
        loadViewIfNeeded()
    }
    func numOfMailChange(num: String){
        
        let updatedText = rootView.numberOfMail.text?.replacingOccurrences(of: "n", with: num)
        
        rootView.numberOfMail.text = updatedText
    }
    

    
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let mailBoxCell = rootView.doorCollectionView.dequeueReusableCell(withReuseIdentifier: MailBoxCollectionViewCell.identifier, for: indexPath) as? MailBoxCollectionViewCell else {
            return UICollectionViewCell()
        }
        
//        mailBoxCell.config(image: dummyData[indexPath.row].doorImage)
        let letterData = homeInfoResponse?.result?.letters
        
        if let letters = letterData {
            // letters 배열에서 id가 indexPath.row와 동일한 요소를 찾기
            if let matchingLetter = letters.first(where: { $0.letterId == indexPath.row }) {
                // 해당 letter의 doorImageUrl을 가져오기
                let imageUrl = matchingLetter.doorImageUrl
                // 이미지 설정
                mailBoxCell.config(imageUrl: imageUrl)
                print("letterData다.")
            } else {
                // id가 일치하는 letter가 없을 경우 처리
                print("해당 id를 가진 letter가 존재하지 않습니다.")
                mailBoxCell.config(imageUrl: "emptyDoor")
            }
        } else {
            // letterData가 nil일 경우 처리
            print("letterData가 nil입니다.")
        }


        
        return mailBoxCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let todayDate = Date()
        let calendar = Calendar.current
        
        // 오늘 날짜의 '일(day)' 추출
        let day = calendar.component(.day, from: todayDate)
        
        let readLetterPosibleDate = indexPath.row + 1
            
        if (day >= readLetterPosibleDate){
            guard let letterId = homeInfoResponse?.result?.letters[indexPath.row].letterId else {return}
            let viewController = ReadLetterViewController(type: .home, letterId: letterId)
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
