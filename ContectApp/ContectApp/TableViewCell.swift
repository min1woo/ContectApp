//
//  TableViewCell.swift
//  ContectApp
//
//  Created by 유민우 on 7/15/24.
//

import UIKit
import SnapKit

final class TableViewCell: UITableViewCell {
    
    var phoneBook: [PhoneBook] = []
    
    static let id = "TableViewCell"
    
    private let profileImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.gray.cgColor
        image.layer.cornerRadius = 35
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "name"
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    private let phoneNumber: UILabel = {
        let label = UILabel()
        label.text = "010-0000-0000"
        label.textAlignment = .right
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        contentView.backgroundColor = .white
        [
            profileImage,
            nameLabel,
            phoneNumber].forEach { contentView.addSubview($0) }
        
        profileImage.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.leading.equalToSuperview().inset(10)
            $0.width.height.equalTo(70)
        }
        
        nameLabel.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.leading.equalTo(profileImage.snp.trailing).offset(30)
        }
        
        phoneNumber.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(30)
        }
    }
    
    // 셀 구성 메서드
    public func configureCell(name: String, phoneNumber: String, profileImageURL: String?) {
        if let urlString = profileImageURL, let url = URL(string: urlString) {
            profileImage.kf.setImage(with: url)
        } else {
            return
        }
        nameLabel.text = name
        self.phoneNumber.text = phoneNumber
    }
}
