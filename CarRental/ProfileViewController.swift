//
//  ProfileViewController.swift
//  CarRental
//
//  Created by Ferid Suleymanzade on 31.07.26.
//

import UIKit

class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logoutTapped))
    }
    
    @objc private func logoutTapped() {
        UserDefaults.standard.removeObject(forKey: "isLoggedIn")
        
        print("LOGOUT:", UserDefaults.standard.bool(forKey: "isLoggedIn"))
        
        let loginVC = LoginViewController()
        let navigationController = UINavigationController(rootViewController: loginVC)
        
        view.window?.rootViewController = navigationController
        view.window?.makeKeyAndVisible()
    }
}
