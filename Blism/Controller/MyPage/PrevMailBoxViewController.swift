//
//  PrevMailBoxViewController.swift
//  Blism
//
//  Created by 이수현 on 12/19/24.
//

import UIKit
import Moya

class PrevMailBoxViewController: UIViewController {
    private let prevMailBoxView = PrevMailBoxView()

    
    var pastMailboxInfo : PastMailboxCheckingResponse?
    private let provider = MoyaProvider<MailboxTargetType>()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = prevMailBoxView
        
        setProtocol()
        setNavigationBar()
        
        PastMailboxInfoResponse()
    }
    private func setProtocol(){
        prevMailBoxView.collectionView.dataSource = self
        prevMailBoxView.collectionView.delegate = self
    }
    
    private func setNavigationBar(){
        // 뒤로 가기 버튼
        let leftBarButton = UIBarButtonItem(image: .popIcon, style: .plain, target: self, action: #selector(popAction))
        leftBarButton.tintColor = .base2
        self.navigationItem.setLeftBarButton(leftBarButton, animated: true)
        
        // 타이틀
        self.navigationItem.titleView = NavigationTitleView(title: "예전에 받은 우체통", titleColor: .base2)
    }
    
    @objc
    private func popAction(){
        self.navigationController?.popViewController(animated: true)
    }
    
    private func PastMailboxInfoResponse() {
        let userId = Int64(KeychainService.shared.load(account: .userInfo, service: .memberId) ?? "") ?? 0
        
        let request = PastMailboxCheckingRequest(memberId: userId)
        
        MailboxAPI.shared.pastMailboxCheck(request: request) {[weak self] result in
            switch result {
            case .success(let data):
//                print(data)
                if data.isSuccess {
                    self?.pastMailboxInfo = data
                    self?.prevMailBoxView.collectionView.reloadData()
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


extension PrevMailBoxViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let pastMailCount = pastMailboxInfo?.result?.count {
            return 3
            //return pastMailCount
        } else {
            print("과거에 받은 편지 개수를 가져오지 못했습니다.")
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PrevMailBoxCollectionViewCell.id, for: indexPath) as? PrevMailBoxCollectionViewCell else {
            return UICollectionViewCell()
        }
        
//        cell.config(year: dummyData?[indexPath.row][0] as? String ?? "")
        // 배열이라면, 특정 인덱스를 지정해야 합니다.
        if let pastMailboxList = pastMailboxInfo?.result?.pastMailboxList, pastMailboxList.count > 0 {
            let pastYear = pastMailboxList[indexPath.row].year // 첫 번째 요소의 year 속성
            cell.config(year: pastYear)
            self.prevMailBoxView.isNullData(isNull: false)
        } else {
            self.prevMailBoxView.isNullData(isNull: true)
            print("pastMailboxList가 비어있거나 nil입니다.")
        }

        
        return cell
    }
}

extension PrevMailBoxViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let pastMailboxList = pastMailboxInfo?.result?.pastMailboxList, pastMailboxList.count > indexPath.row {
                // 선택된 항목의 year와 mailCount를 가져옴
                let pastYear = pastMailboxList[indexPath.row].year
                
                // 다음 화면으로 데이터 전달
                let nextVC = PrevMailBoxDetailViewController(year: pastYear)
                self.navigationController?.pushViewController(nextVC, animated: true)
            } else {
                print("pastMailboxList가 비어있거나 인덱스가 범위를 벗어났습니다.")
            }
    }
}
