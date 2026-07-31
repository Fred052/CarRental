//
//  CarDataService.swift
//  CarRental
//
//  Created by Ferid Suleymanzade on 31.07.26.
//

import Foundation

final class CarDataService {
    static let shared = CarDataService()
    
    private init() {}
    
    func loadCars() -> [Car] {
        
        guard let url = Bundle.main.url(
            forResource: "Car",
            withExtension: "json"
        ) else {
            print("Json not found")
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            let cars = try  JSONDecoder().decode([Car].self, from: data)
            
            return cars
            
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
