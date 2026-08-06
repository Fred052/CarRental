//
//  CoreDataService.swift
//  CarRental
//
//  Created by Ferid Suleymanzade on 06.08.26.
//

import UIKit
import CoreData

class CoreDataService {
    static let shared = CoreDataService()
    
    private init() {}
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    func saveCar(_ car: Car) {
        
        let carEntity = CarEntity(context: context)
        
        carEntity.id = Int16(car.id)
        carEntity.brand = car.brand
        carEntity.model = car.model
        carEntity.category = car.category
        carEntity.price = car.price
        carEntity.period = car.period
        carEntity.engine = car.engine
        carEntity.image = car.image
        
        do {
            try context.save()
            print("Cars successfully saved to Core Data")
        } catch {
            print("Car Saved Error",error.localizedDescription)
        }
    }
    
    func saveUser(name: String, email: String, password: String) {
        let user = UserEntity(context: context)
        
        user.name = name
        user.email = email
        user.password = password
        
        do {
            try context.save()
            print("User successfully saved")
        } catch {
            print("User Saved Error",error.localizedDescription)
        }
    }
    
    func fetchCars() -> [CarEntity] {
        let request: NSFetchRequest<CarEntity> = CarEntity.fetchRequest()
        
        do {
            return try context.fetch(request)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func importCarsFromJSON() {
        
        let cars = CarDataService.shared.loadCars()
        
        let existingCars = fetchCars()
        
        let existingIDs = Set(
            existingCars.map { Int($0.id)}
        )
            
            for car in cars {
            
            if existingIDs.contains(car.id) {
                continue
            }
            saveCar(car)
        }
    }
    
    func getCars() -> [Car] {
        
        let carEntities = fetchCars()
        
        return carEntities.map { entity in
            
            Car (
                id: Int(entity.id),
                brand: entity.brand ?? "",
                model: entity.model ?? "",
                category: entity.category ?? "",
                price: entity.price,
                period: entity.period ?? "",
                engine: entity.engine ?? "",
                image: entity.image ?? ""
            )
        }
    }
    
    func userExists(email: String) -> Bool {
        let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        request.predicate = NSPredicate(format: "email == %@", email)
        
        do {
            let users = try context.fetch(request)
            return !users.isEmpty
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    func loginUser(email: String, password: String) -> Bool {
        let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        request.predicate = NSPredicate(format: "email == %@ AND password == %@", email, password)
        
        do {
            let users = try context.fetch(request)
            return !users.isEmpty
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
}
