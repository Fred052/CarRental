//
//  CarEntity+CoreDataProperties.swift
//  CarRental
//
//  Created by Ferid Suleymanzade on 06.08.26.
//
//

public import Foundation
public import CoreData


public typealias CarEntityCoreDataPropertiesSet = NSSet

extension CarEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CarEntity> {
        return NSFetchRequest<CarEntity>(entityName: "CarEntity")
    }

    @NSManaged public var brand: String?
    @NSManaged public var category: String?
    @NSManaged public var engine: String?
    @NSManaged public var id: Int16
    @NSManaged public var image: String?
    @NSManaged public var model: String?
    @NSManaged public var period: String?
    @NSManaged public var price: Double

}

extension CarEntity : Identifiable {

}
