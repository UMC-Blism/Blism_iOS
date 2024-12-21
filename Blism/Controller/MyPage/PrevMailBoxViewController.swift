//
//  PrevMailBoxViewController.swift
//  Blism
//
//  Created by 이수현 on 12/19/24.
//

import UIKit
import Moya

class PrevMailBoxViewController: UIViewController {
    private let prevMailBoxView : PrevMailBoxView
    
    private let dummyData : [[Any]]?
    
    var pastMailboxInfo : PastMailboxResponse?
    private let provider = MoyaProvider<MailboxTargetType>()
    
    init(data: [[Any]]?) {
        self.dummyData = data
        self.prevMailBoxView = PrevMailBoxView()
        prevMailBoxView.isNullData(isNull: data == nil ? true : false)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = prevMailBoxView
        
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
        let userId = Int(KeychainService.shared.load(account: .userInfo, service: .memberId) ?? "") ?? 0
        provider.request(.getAllPastMail){ result in
            switch result {
            case .success(let response):
                print(response)
                print("Request URL: \(response.request?.url?.absoluteString ?? "No URL")")
                do {
                    
                    let pastMailBoxInfoResponse = try response.map(PastMailboxResponse.self)
                    self.pastMailboxInfo = pastMailBoxInfoResponse
                    
                } catch {
                    // 변환 실패 시 오류 처리
                    print("Mapping error: \(error.localizedDescription)")
                }
            case .failure(let error):
                print("Network request error: \(error.localizedDescription)")
            }
        }
        
    }
}


extension PrevMailBoxViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummyData?.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PrevMailBoxCollectionViewCell.id, for: indexPath) as? PrevMailBoxCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.config(year: dummyData?[indexPath.row][0] as? String ?? "")
        return cell
    }
}

extension PrevMailBoxViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // API 연결
        let year = dummyData?[indexPath.row][0] as? String ?? ""
        let count = dummyData?[indexPath.row][1] as? Int ?? 0
        let nextVC = PrevMailBoxDetailViewController(year: year, mailCount: count)
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
