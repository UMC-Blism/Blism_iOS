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
//        KeychainService.shared.delete(account: .userInfo, service: .memberId)
        let visible = KeychainService.shared.load(account: .userInfo, service: .visibilityPermission)
        if visible == nil{
            viewController.modalPresentationStyle = .overFullScreen
            present(viewController, animated: false)
        }else{
            print("권한 설정이 되어있습니다")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("homeVC -viewWIllAppear")
        self.navigationController?.navigationBar.isHidden = true
        
        // API 호출
        let nickname = KeychainService.shared.load(account: .userInfo  , service: .nickname) ?? "닉네임 오류"
//        KeychainService.shared.save(account: .userInfo, service: .memberId, value: "10")
//        KeychainService.shared.save(account: .userInfo, service: .nickname, value: "누찬")
        
        // 키체인 불러오기
        if let memberId = KeychainService.shared.load(account: .userInfo, service: .memberId), let nickname = KeychainService.shared.load(account: .userInfo, service: .nickname) {
            
            
            fetchMailBoxInfo(userId: memberId) //임시 아이디 원대는 (userId: memberId)
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
                    
                    let numberOfMail = String(self?.homeInfoResponse?.result?.count ?? 0)
                    print("&&&& \(self?.homeInfoResponse?.result?.count)")
                    self?.numOfMailChange(num: numberOfMail)
                    let mailboxId = String(self?.homeInfoResponse?.result?.mailboxId ?? 0)
                    KeychainService.shared.save(account: .userInfo, service: .mailboxId, value: mailboxId)
                    self?.rootView.doorCollectionView.reloadData()
                    ReplyLetterData.shared.mailbox_id = self?.homeInfoResponse?.result?.mailboxId ?? Int64(0)
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
//        let updatedText = rootView.mailboxOwner.text?.replacingOccurrences(of: "지수", with: nickname)
        let updatedText = "\(nickname)님의 우체통"
        rootView.mailboxOwner.text = updatedText
        loadViewIfNeeded()
    }
    func numOfMailChange(num: String){
        
//        let updatedText = rootView.numberOfMail.text?.replacingOccurrences(of: "n", with: num)
        let updatedText = "\(num)개의 둥지가 완성됐어요!"
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
        
        let letterData = homeInfoResponse?.result?.letters
        if let letters = letterData {
            let index = indexPath.row
            if index < letters.count { // 배열 범위 초과 방지
                let doorImageUrl = letters[index].doorImageUrl // 비옵셔널(String)이라면 바로 사용 가능
                mailBoxCell.config(imageUrl: doorImageUrl)
                print("doorImageUrl 설정 완료: \(doorImageUrl)")
            } else {
                print("indexPath.row가 letters 배열 범위를 벗어났습니다.")
                mailBoxCell.config(imageUrl: "emptyDoor")
            }
        }
        return mailBoxCell
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        let letterData = homeInfoResponse?.result?.letters


        if let letters = letterData {
            let index = indexPath.row
            if index < letters.count {
                
                let todayDate = Date()
                let calendar = Calendar.current
                
                // 오늘 날짜의 '일(day)' 추출
                let day = calendar.component(.day, from: todayDate)
                
                let readLetterPosibleDate = indexPath.row + 1
                
                if (day >= readLetterPosibleDate){
                    
                    guard let letterID = letterData?[indexPath.row].letterId else {
                        print("letterId를 가져오는데 실패했습니다 301")
                        return
                    }
                    
                    let viewController = ReadLetterViewController(type: .home, letterId: letterID)

                    viewController.modalPresentationStyle = .overFullScreen
                    present(viewController, animated: false)
                }else{
                    
                    let viewController = HomeDateAlertViewController()
                    
                    viewController.readLetterPosibleDateReceiver = readLetterPosibleDate
                    viewController.modalPresentationStyle = .overFullScreen
                    present(viewController, animated: false)
                }
                
            } else {
                print("편지가 없어서 편지를 읽는 view로 이동할 수 없습니다")
            }
        }
        
        
    }
    
}

