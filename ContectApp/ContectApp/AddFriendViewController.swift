//
//  addFriendView.swift
//  ContectApp
//
//  Created by 유민우 on 7/16/24.
//

import UIKit
import SnapKit
import Alamofire
import Kingfisher

class AddFriendViewController: UIViewController {
    
    var phoneBooks: [PhoneBook] = []
    
    // 적용 버튼
    private lazy var applyButton = UIBarButtonItem(title: "적용", style: .plain, target: self, action: #selector(tappedApply))
    
    // 프로필 이미지
    private let profileImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.gray.cgColor
        image.layer.cornerRadius = 75
        return image
    }()
    
    private var profileImageURL: String?
    
    // 랜덤이미지 생성 버튼
    private lazy var randomButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("랜덤 이미지 생성", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(loadImage), for: .touchUpInside)
        return button
    }()
    
    // 이름 적는 곳
    private let nameTextView: UITextView = {
        let textView = UITextView()
        //   textView.text = "이름"
        textView.font = UIFont.boldSystemFont(ofSize: 20)
        textView.textAlignment = .left
        textView.backgroundColor = .white
        textView.layer.cornerRadius = 10
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.gray.cgColor
        return textView
    }()
    
    // 전화번호 적는 곳
    private let phonenumberTextView: UITextView = {
        let textView = UITextView()
        // textView.text = "전화번호"
        textView.font = UIFont.boldSystemFont(ofSize: 20)
        textView.textAlignment = .left
        textView.backgroundColor = .white
        textView.layer.cornerRadius = 10
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.gray.cgColor
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        phoneBooks = PhoneBookManager.shared.fetchPhoneBook() // 저장된 연락처 불러오기
        
        // 버튼을 뷰에 올리기
        self.navigationItem.rightBarButtonItem = applyButton
        // 타이틀 라벨 올리기
        self.title = "연락처 추가"
    }
    
    
    
    // kingPisher 을 사용하여 서버에서 이미지 불러오기
    public func makeRandomPoketmon() {
       
        let imageUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(Int.random(in: 0...1000)).png"
        profileImageURL = imageUrl
        profileImage.kf.setImage(with: URL(string: imageUrl))
    }
    
        func configureUI() {
            [
                profileImage,
                randomButton,
                nameTextView,
                phonenumberTextView ].forEach { view.addSubview($0) }
            
            profileImage.snp.makeConstraints {
                $0.top.equalToSuperview().offset(100)
                $0.centerX.equalToSuperview()
                $0.width.height.equalTo(150)
            }
            
            randomButton.snp.makeConstraints {
                $0.top.equalTo(profileImage.snp.bottom).offset(10)
                $0.centerX.equalToSuperview()
            }
            
            nameTextView.snp.makeConstraints {
                $0.top.equalTo(randomButton.snp.bottom).offset(30)
                $0.leading.trailing.equalToSuperview().inset(10)
                $0.height.equalTo(40)
            }
            
            phonenumberTextView.snp.makeConstraints {
                $0.top.equalTo(nameTextView.snp.bottom).offset(15)
                $0.leading.trailing.equalToSuperview().inset(10)
                $0.height.equalTo(40)
            }
        }
    
    
    
    // 적용버튼 액션 매서드
    @objc func tappedApply() {
        // 이름과 전화번호가 입력되었는지 확인
        guard let name = nameTextView.text, !name.isEmpty,
              let phoneNumber = phonenumberTextView.text, !phoneNumber.isEmpty,
              let profileImageURL = profileImageURL  else {
            // 경고 메세지 출력
            let alert = UIAlertController(title: "입력오류", message: "이름, 전화번호, 프로필이미지가 모두 필요합니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            present(alert, animated: true)
            return
        }
        
        // 이전화면으로 돌아가기
        navigationController?.popViewController(animated: true)
        
        // Core Data 에 연락처 저장
        PhoneBookManager.shared.savePhoneBook(name: name, phoneNumber: phoneNumber, profileImageURL: profileImageURL)
    }
   
    // 랜덤 이미지 생성 버튼 액션 메서드
    @objc private func loadImage() {
        makeRandomPoketmon()
    }
    
}

