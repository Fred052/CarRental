//
//  UserEntity+CoreDataProperties.swift
//  CarRental
//
//  Created by Ferid Suleymanzade on 06.08.26.
//
//

public import Foundation
public import CoreData


public typealias UserEntityCoreDataPropertiesSet = NSSet

extension UserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var password: String?
    @NSManaged public var email: String?

}

extension UserEntity : Identifiable {

}
