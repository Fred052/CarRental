//
//  ValidationService.swift
//  CarRental
//
//  Created by Ferid Suleymanzade on 31.07.26.
//

import Foundation

final class ValidationService {
    static let shared = ValidationService()
    
    private init() {}
        
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(
            format: "SELF MATCHES %@",
            emailRegEx).evaluate(with: email)
    }
    
    func isvalidPassword(_ password: String) -> Bool {
        let passwordRegEx = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[^A-Za-z0-9]).{8,}$"
        return NSPredicate(
            format: "SELF MATCHES %@"
            , passwordRegEx).evaluate(with: password)
    }
}
