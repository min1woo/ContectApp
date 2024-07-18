//
//  PhoneBook+CoreDataProperties.swift
//  ContectApp
//
//  Created by 유민우 on 7/17/24.
//
//
import Foundation
import CoreData


extension PhoneBook {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhoneBook> {
        return NSFetchRequest<PhoneBook>(entityName: "PhoneBook")
    }

    @NSManaged public var name: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var profileImageURL: String?

}

extension PhoneBook : Identifiable {

}
