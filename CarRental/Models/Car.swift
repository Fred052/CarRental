//
//  Car.swift
//  CarRental
//
//  Created by Ferid Suleymanzade on 31.07.26.
//

import Foundation

struct Car: Codable {
    let id: Int
    let brand: String
    let model: String
    let category: String
    let price: Double
    let period: String
    let engine: String
    let image: String
}
