//
//  MainTabBarController.swift
//  CarRental
//
//  Created by Ferid Suleymanzade on 31.07.26.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Car Rental"
        
        setupTabs()
    }
    
    private func setupTabs() {
        
        let homeVC = HomeViewController()
        let searchVC = SearchViewController()
        let profileVC = ProfileViewController()
        
        homeVC.tabBarItem = UITabBarItem(
            title: "Vehicles",
            image: UIImage(systemName: "car.circle"),
            selectedImage: UIImage(systemName: "car.circle.fill")
        )
        
        searchVC.tabBarItem = UITabBarItem(
            title: "Search",
            image: UIImage(systemName: "magnifyingglass"),
            selectedImage: UIImage(systemName: "magnifyingglass.fill")
        )
        
        profileVC.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill")
        )
        
        viewControllers = [
            homeVC,
            searchVC,
            profileVC
        ]
        
        selectedIndex = 0
    }
}
