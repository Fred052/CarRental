//
//  HomeViewController.swift
//  CarRental
//
//  Created by Ferid Suleymanzade on 31.07.26.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var cars: [Car] = []
    private var categories: [String] = []
    
    private var selectedCategoryIndex: Int?
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for a car"
        searchBar.searchBarStyle = .minimal
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private let availableVehicleLabel: UILabel = {
       let label = UILabel()
        label.text = "Available Vehicles"
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        
        let offset = UIOffset(horizontal: 10.0, vertical: 0.0)
        searchBar.setPositionAdjustment(offset, for: .search)
        
        setupCollectionView()
        setupConstraints()
        
        loadCars()
    }
    
    private let categoryCollectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 120, height: 160)
        layout.minimumLineSpacing = 30
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private let vehicleCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width:UIScreen.main.bounds.width - 50, height: 320)
        layout.minimumLineSpacing = 20
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    private func setupCollectionView() {
        
        view.addSubview(searchBar)
        view.addSubview(categoryCollectionView)
        view.addSubview(availableVehicleLabel)
        view.addSubview(vehicleCollectionView)
        
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        
        vehicleCollectionView.delegate = self
        vehicleCollectionView.dataSource = self
        
        categoryCollectionView.register(
            CarCategoryCollectionViewCell.self,
            forCellWithReuseIdentifier:
                CarCategoryCollectionViewCell.identifier
        )
        vehicleCollectionView.register(
            VehicleCollectionViewCell.self,
            forCellWithReuseIdentifier: VehicleCollectionViewCell.identifier
        )
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 6),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchBar.heightAnchor.constraint(equalToConstant: 30),
            
            categoryCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 35),
            categoryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            categoryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            categoryCollectionView.heightAnchor.constraint(equalToConstant: 160),
            
            availableVehicleLabel.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor, constant: 30),
            availableVehicleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            availableVehicleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            vehicleCollectionView.topAnchor.constraint(equalTo: availableVehicleLabel.bottomAnchor, constant: 15),
            vehicleCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            vehicleCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            vehicleCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    private func loadCars() {
        cars = CarDataService.shared.loadCars()
        
        categories = Array(
            Set(cars.map {$0.category})
        ).sorted()
        categoryCollectionView.reloadData()
    }
    
    
}


extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollectionView {
            return categories.count
        }
        return cars.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == categoryCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarCategoryCollectionViewCell.identifier, for: indexPath) as! CarCategoryCollectionViewCell
            
            let category = categories[indexPath.item]
            
            let categoryCars = cars.filter {
                $0.category == category
            }
            
            let categoryCar = categoryCars.first
            
            cell.configure(
                image: UIImage(named: categoryCar?.image ?? "")!,
                category: category,
                count: categoryCars.count,
                isSelected: indexPath.item == selectedCategoryIndex
            )
            return cell
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VehicleCollectionViewCell.identifier, for: indexPath) as! VehicleCollectionViewCell
            
            let car = cars[indexPath.item]
            
            print("Vehicle cell:", car.brand, car.model)
            
            cell.configure(with: car)
            
            return cell
        }
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            selectedCategoryIndex = indexPath.item
            categoryCollectionView.reloadData()
        }
    }
}
