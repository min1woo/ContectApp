//
//  ViewController.swift
//  ContectApp
//
//  Created by 유민우 on 7/15/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    // 연락처 저장소
    var phoneBooks: [PhoneBook] = []
    
    // 타이틀 라벨 - 친구목록
    private let titleLable: UILabel = {
        let label = UILabel()
        label.text = "친구 목록"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .black
        return label
    }()
    // 추가 버튼
   private lazy var addButton = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addPhoneBook))
    
    
    // 친구목록이 들어갈 테이블 뷰
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.id)
        return tableView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        self.navigationItem.rightBarButtonItem = addButton
        phoneBooks = PhoneBookManager.shared.fetchPhoneBook()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        phoneBooks = PhoneBookManager.shared.fetchPhoneBook()
        tableView.reloadData() // 테이블 뷰 갱신
    }
    
    
    
    private func configureUI() {
        view.backgroundColor = .white
        
        [
            titleLable,
            tableView
        ].forEach { view.addSubview($0) }
        
        titleLable.snp.makeConstraints {
            $0.top.equalToSuperview().offset(70)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(120)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(titleLable.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            
        }
    }


}

extension ViewController: UITableViewDelegate {
    // 테이블 뷰 셀 높이 크기 지정.
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 80
    }
}
extension ViewController: UITableViewDataSource {
    // 테이블 뷰의 indexPath 마다 테이블 뷰 셀을 지정
    // indexpath: 테이블 뷰의 행과 섹션을 의미
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.id) as? TableViewCell else {
            return UITableViewCell()
        }
        let phoneBook = phoneBooks[indexPath.row] // 해당 인덱스의 연락처 가져오기
        cell.configureCell(name: phoneBook.name ?? "", phoneNumber: phoneBook.phoneNumber ?? "", profileImageURL: phoneBook.profileImageURL ?? "")
        return cell
    }
    
    // 테이블 뷰 섹션의 행이 몇 개 들어가는가 (저장된 연락처 갯수만큼 반환)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return phoneBooks.count
    }
    
    @objc private func addPhoneBook() {
        self.navigationController?.pushViewController(AddFriendViewController(), animated: true)
    }
    
}

