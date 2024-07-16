//
//  addFriendView.swift
//  ContectApp
//
//  Created by 유민우 on 7/16/24.
//

import UIKit

class AddFriendViewController: UIViewController {
    
    // 적용 버튼
    private lazy var applyButton = UIBarButtonItem(title: "적용", style: .plain, target: self, action: #selector(tappedApply))
    
    // 프로필 이미지
    private let profileImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "good")
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.gray.cgColor
        image.layer.cornerRadius = 75
        return image
    }()
    
    // 랜덤이미지 생성 버튼
    private let randomButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("랜덤 이미지 생성", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        return button
    }()
    
    // 이름 적는 곳
    private let nameTextView: UITextView = {
        let textView = UITextView()
        textView.text = "이름"  
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
        textView.text = "전화번호"
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
       
        // 버튼을 뷰에 올리기
        self.navigationItem.rightBarButtonItem = applyButton
        // 타이틀 라벨 올리기
        self.title = "연락처 추가"
        
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
            $0.top.equalTo(nameTextView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(40)
        }
    }
    
    @objc private func tappedApply() {
        
    }
    
}
