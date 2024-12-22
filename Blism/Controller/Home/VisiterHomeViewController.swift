//
//  VisiterHomeViewController.swift
//  Blism
//
//  Created by 송재곤 on 12/19/24.
//
import UIKit

class VisiterHomeViewController: UIViewController {
    
    private let rootView = VisiterHomeView()
    
    let viewController = HomeDoNotDisclosureViewController()
    
    let navTitle = NavTitleStackView()
    private let mailBoxId : Int64     // viewDidLoad()에서 우체통 조회 API에서 사용
    private let memberId: Int64 // 우체통 조회 API의 Request로 활용
    private let nickname: String // 우체통 조회 API의 Request로 활용
    
    var otherHomeInfoResponse : MailboxCheckingResponse?
    
    init(mailBoxId: Int64, memberId: Int64, nickname: String) {
        self.mailBoxId = mailBoxId
        self.memberId = memberId
        self.nickname = nickname
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("VisiterHomeViewController viewDidLoad - mailBoxId \(mailBoxId) ")
        view = rootView
        rootView.doorCollectionView.dataSource = self
        rootView.doorCollectionView.delegate = self
        self.navigationController?.navigationBar.isHidden = false
        
        
        nicknameChange(nickname: nickname) //이부분은 로그인할때 받아옴
        
        tapRecognizer()
        setNavigationBar()
        let otherMemberId = String(memberId)
        fetchOtherMailBoxInfo(userId: otherMemberId)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.isTabBarHidden = false

    }
    
    private func setNavigationBar(){
        // 뒤로 가기 버튼
        let leftBarButton = UIBarButtonItem(image: .popIcon, style: .plain, target: self, action: #selector(goBack))
        leftBarButton.tintColor = .white
        self.navigationItem.setLeftBarButton(leftBarButton, animated: true)
        
        
        self.navigationItem.titleView = navTitle
    }

    private func nicknameChange(nickname: String){
        
        let updatedText = rootView.mailboxOwner.text?.replacingOccurrences(of: "지수", with: nickname)
        
        rootView.mailboxOwner.text = updatedText
        navTitle.mailboxOwner.text = updatedText
        
    }
    
    private func tapRecognizer(){
        
        rootView.backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
    }
    
    @objc private func goBack(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func goToWriteLetter(){
        //nav 추가
        print("작성")
    }
    // API 호출 함수
    private func fetchOtherMailBoxInfo(userId: String) {
        guard let memberId = Int64(userId) else {return}
        
        let request = MailboxCheckingRequest(memberId: memberId)
        MailboxAPI.shared.mailboxCheck(request: request) {[weak self] result in
            switch result {
            case .success(let data):
                print("\(data)**")
                if data.isSuccess {
                    self?.otherHomeInfoResponse = data
                    
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
    
}

extension VisiterHomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let mailBoxCell = rootView.doorCollectionView.dequeueReusableCell(withReuseIdentifier: MailBoxCollectionViewCell.identifier, for: indexPath) as? MailBoxCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let letterData = otherHomeInfoResponse?.result?.letters
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

        
        let letterData = otherHomeInfoResponse?.result?.letters
        
        
        if let letters = letterData {
            let index = indexPath.row
            if index < letters.count {
                
                let letterData = otherHomeInfoResponse?.result
                
                if let letters = letterData {
                    if letters.visibility == 1 {
                        guard let letterID = letterData?.letters[indexPath.row].letterId else {
                            print("letterId를 가져오는데 실패했습니다 301")
                            return
                        }
                        let viewController = ReadLetterViewController(type: .home, letterId: letterID)
                        viewController.modalPresentationStyle = .overFullScreen
                        present(viewController, animated: false)
                    }else {
                        //비공개 우편함입니다 띄우기
                        viewController.modalPresentationStyle = .overFullScreen
                        present(viewController, animated: false)
                        print("편지를 조회할 수 없습니다")
                    }
                }
                
            }else{
                let letter = otherHomeInfoResponse?.result
                if let letterData = letter{
                    let receiverId = letterData.memberId
                    let receivermailboxId = letterData.mailboxId
                    let nextVC = WriteLetterViewController(receiverId: receiverId, mailboxId: receivermailboxId)
                    self.navigationController?.pushViewController(nextVC, animated: true)
                    print("편지작성 뷰로 이동")
                }
            }
            
        } else {
           
        }
    }
    
    
}
