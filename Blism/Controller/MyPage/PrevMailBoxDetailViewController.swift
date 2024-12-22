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
        //1
        prevMailBoxDetailView.collectionView.register(
                PastLetterCollectionViewCell.self,
                forCellWithReuseIdentifier: PastLetterCollectionViewCell.identifier
            )
        
        setProtocol()
        setNavigationBar()
        SpecificPastMailboxInfoResponse()
       
    }
    
    private func setProtocol(){
        prevMailBoxDetailView.collectionView.dataSource = self
        prevMailBoxDetailView.collectionView.delegate = self
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


extension PrevMailBoxDetailViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if let specificPastLetterCount = specificPastMailboxInfo?.result?.count {
//            return specificPastLetterCount
//        } else {
//            print("과거에 받은 편지 개수를 가져오지 못했습니다.")
//            return 0
//        }
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PastLetterCollectionViewCell.identifier, for: indexPath) as? PastLetterCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let letterData = specificPastMailboxInfo?.result?.letters
        
        if let letters = letterData {
            let index = indexPath.row
            if index < letters.count { // 배열 범위 초과 방지
                let doorImageUrl = letters[index].doorImageUrl // 비옵셔널(String)이라면 바로 사용 가능
                cell.config(imageUrl: doorImageUrl)
                print("doorImageUrl 설정 완료: \(doorImageUrl)")
            } else {
//                print("indexPath.row가 letters 배열 범위를 벗어났습니다.")
                cell.config(imageUrl: "emptyDoor")
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        let letterData = specificPastMailboxInfo?.result?.letters


        if let letters = letterData {
            let index = indexPath.row
            if index < letters.count {
                    
                    guard let letterID = letterData?[indexPath.row].letterId else {
                        print("letterId를 가져오는데 실패했습니다 301")
                        return
                    }
                    
                    let viewController = ReadLetterViewController(type: .home, letterId: letterID)

                    viewController.modalPresentationStyle = .overFullScreen
                    present(viewController, animated: false)
                
            } else {
                print("편지가 없어서 편지를 읽는 view로 이동할 수 없습니다")
            }
        }
        
        
    }
    
}
