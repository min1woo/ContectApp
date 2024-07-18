//
//  PhoneBookManager.swift
//  ContectApp
//
//  Created by 유민우 on 7/17/24.
//

import UIKit
import CoreData

class PhoneBookManager {
    
    static let shared = PhoneBookManager()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // 연락처 저장 함수
    func savePhoneBook(name: String, phoneNumber: String, profileImageURL: String) {
        let newPhoneBook = PhoneBook(context: context) // 새로운 PhoneBook 객체 생성
        newPhoneBook.name = name
        newPhoneBook.phoneNumber = phoneNumber
        newPhoneBook.profileImageURL = profileImageURL
        
        do {
            try context.save() // 컨텍스트 저장
        } catch {
            print("연락처 저장 실패")
        }
    }
    
    // 연락처를 불러오는 함수
    func fetchPhoneBook() -> [PhoneBook] {
        let fetchRequest: NSFetchRequest<PhoneBook> = PhoneBook.fetchRequest() // fetch request 생성
        
        // 이름을 기준으로 오름차순 정렬
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            let phoneBooks = try context.fetch(fetchRequest) // fetch 실행
            return phoneBooks
        } catch {
            print("연락처 가져오기 실패")
            return []
        }
    }
    
    // 모든 연락처를 삭제하는 함수
    func deleteAllPhoneBooks() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = PhoneBook.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print("모든 연락처 삭제 실패: \(error)")
        }
    }
    
}

