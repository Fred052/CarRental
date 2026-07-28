//
//  FileManagerService.swift
//  CarRental
//
//  Created by Ferid Suleymanzade on 28.07.26.
//


import Foundation

final class FileManagerService {
    
    static let shared = FileManagerService()
    
    private init() {}
    
    private func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let url =  urls[0].appendingPathComponent("User.json")
        print(url)
        return url
    }
    
    //Save User
    func saveUser(_ user: User) {
        
        var users = loadUsers()
        
        users.append(user)
        
        do {
            let data = try JSONEncoder().encode(users)
            try data.write(to: fileURL())
            print("User succesfully saved")
        }catch {
            print(error.localizedDescription)
        }
        
        
    }
    
    //Load User
    func loadUsers() -> [User] {
        
        do {
            let data = try Data(contentsOf: fileURL())
            let users = try JSONDecoder().decode([User].self, from: data)
            return users
        }catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func findUser(email: String, password: String) -> User? {
        let users = loadUsers()
        
        return users.first {
            $0.email == email &&
            $0.password == password
        }
    }
    
    func userExists(email: String) -> Bool {
        let users = loadUsers()
        
        return users.contains {
            $0.email == email
        }
    }
}
