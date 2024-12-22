//
//  PrevMailBoxDetailViewController.swift
//  Blism
//
//  Created by 이수현 on 12/19/24.
//

import UIKit
import Moya

class PrevMailBoxDetailViewController: UIViewController {
    private let prevMailBoxDetailView: PrevMailBoxDetailView
    private let year: String
    
    var specificPastMailboxInfo : SpecificPastMailboxCheckingResponse?
    private let provider = MoyaProvider<MailboxTargetType>()
    
    init(year: String) {
        self.year = year
        self.prevMailBoxDetailView = PrevMailBoxDetailView(year: year)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = prevMailBoxDetailView
        
        setProtocol()
        setNavigationBar()
        SpecificPastMailboxInfoResponse()
       
    }
    
    private func setProtocol(){
        prevMailBoxDetailView.collectionView.dataSource = self
    }
    
    private func setNavigationBar(){
        // 뒤로 가기 버튼
        let leftBarButton = UIBarButtonItem(image: .popIcon, style: .plain, target: self, action: #selector(popAction))
        leftBarButton.tintColor = .base2
        self.navigationItem.setLeftBarButton(leftBarButton, animated: true)
        
        // 타이틀
        let title = "\(year)년에 받은 우체통"
        self.navigationItem.titleView = NavigationTitleView(title: title, titleColor: .base2)
    }
    
    @objc
    private func popAction(){
        self.navigationController?.popViewController(animated: true)
    }
    private func SpecificPastMailboxInfoResponse() {
        let userId = Int64(KeychainService.shared.load(account: .userInfo, service: .memberId) ?? "") ?? 0
        
        let request = SpecificPastMailboxCheckingRequest(memberId: userId, year: year)
        
        MailboxAPI.shared.specificPastMailboxCheck(request: request) {[weak self] result in
            switch result {
            case .success(let data):
                print(data)
                if data.isSuccess {
                    self?.specificPastMailboxInfo = data
                    if let count = data.result?.count {
                        // count가 nil이 아닌 경우
                        self?.numOfMailChange(num: count)
                    } else {
                        // count가 nil인 경우 기본값을 사용
                        print("n 바꾸기 실패")
                    }
                    self?.prevMailBoxDetailView.collectionView.reloadData()
                } else {
                    print("data isFailed")
                }
                
            case .failure(let error):
                let alert = NetworkAlert.shared.getAlertController(title: error.description)
                self?.present(alert, animated: true)
            }
        }
    }
    func numOfMailChange(num: Int){
        let stringNum = String(num)
        let updatedText = self.prevMailBoxDetailView.titleLabel.text?.replacingOccurrences(of: "n", with: stringNum)
        
        self.prevMailBoxDetailView.titleLabel.text = updatedText
    }

}


extension PrevMailBoxDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let specificPastLetterCount = specificPastMailboxInfo?.result?.count {
            return specificPastLetterCount
        } else {
            print("과거에 받은 편지 개수를 가져오지 못했습니다.")
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MailBoxCollectionViewCell.identifier, for: indexPath) as? MailBoxCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let letterData = specificPastMailboxInfo?.result?.letters
        
        if let letters = letterData {
            // letters 배열에서 id가 indexPath.row와 동일한 요소를 찾기
            if let matchingLetter = letters.first(where: { $0.letterId == indexPath.row }) {
                // 해당 letter의 doorImageUrl을 가져오기
                let imageUrl = matchingLetter.doorImageUrl
                // 이미지 설정
                cell.config(imageUrl: imageUrl)
                print("letterData다.")
            } else {
                // id가 일치하는 letter가 없을 경우 처리
                print("해당 id를 가진 letter가 존재하지 않습니다.")
                cell.config(imageUrl: "emptyDoor")
            }
        } else {
            // letterData가 nil일 경우 처리
            print("letterData가 nil입니다.")
        }
        return cell
    }
}
