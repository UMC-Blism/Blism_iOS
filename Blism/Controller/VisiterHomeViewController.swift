//
//  VisiterHomeViewController.swift
//  Blism
//
//  Created by 송재곤 on 12/19/24.
//
import UIKit

class VisiterHomeViewController: UIViewController {
    
    private let rootView = VisiterHomeView()
    let viewController = HomeDisclosureViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = rootView
        rootView.doorCollectionView.dataSource = self
        rootView.doorCollectionView.delegate = self
        
        nicknameChange(nickname: "아진") //이부분은 로그인할때 받아옴
        
        tapRecognizer()
        
        
    }

    private func nicknameChange(nickname: String){
        
        let updatedText = rootView.mailboxOwner.text?.replacingOccurrences(of: "지수", with: nickname)
        
        rootView.mailboxOwner.text = updatedText
    }
    
    private func tapRecognizer(){
        let writeLetterTapGesture = UITapGestureRecognizer(target: self, action: #selector(goToWriteLetter))
        rootView.writeLetter.addGestureRecognizer(writeLetterTapGesture)
        rootView.writeLetter.isUserInteractionEnabled = true
        
        rootView.backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
    }
    
    @objc private func goBack(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func goToWriteLetter(){
        //nav 추가
        print("작성")
    }
    
}

extension VisiterHomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
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
            
            viewController.view.backgroundColor = UIColor.black.withAlphaComponent(0.5) //투명도 50
            viewController.modalPresentationStyle = .overFullScreen
            present(viewController, animated: true)
        }else{
            
            let viewController = HomeDateAlertViewController()
            
            viewController.readLetterPosibleDateReceiver = readLetterPosibleDate
            viewController.view.backgroundColor = UIColor.black.withAlphaComponent(0.5) //투명도 50
            viewController.modalPresentationStyle = .overFullScreen
            present(viewController, animated: false)
            

        }
        
    }
   
}
