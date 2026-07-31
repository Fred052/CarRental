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
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        
        let offset = UIOffset(horizontal: 10.0, vertical: 0.0)
        searchBar.setPositionAdjustment(offset, for: .search)
        
        setupSearchBar()
        setupCollectionView()
        
        loadCars()
        
        collectionView.setCollectionViewLayout(createLayout(), animated: false)
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, _ in
            
            if sectionIndex == 0 {
                return self.createCategorySection()
            } else {
                return self.createVehicleSection()
            }
            
        }
    }
    
    private func createCategorySection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(120),
            heightDimension: .absolute(160)
        )
        
        let item = NSCollectionLayoutItem(
            layoutSize: itemSize
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: itemSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = .continuous
        
        section.interGroupSpacing = 15
        
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 10,
            leading: 20,
            bottom: 10,
            trailing: 20
        )
        
        return section
    }
    
    
    private func createVehicleSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(380)
        )
        
        let item = NSCollectionLayoutItem(
            layoutSize: itemSize
        )
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: itemSize,
            subitems: [item]
            )
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.interGroupSpacing = 20
        
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 10,
            leading: 20,
            bottom: 10,
            trailing: 20
        )
        
        return section
    }
    
    
    
    
    private func setupSearchBar() {
        
        view.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 10
            ),
            searchBar.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16
            ),
            searchBar.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -16
            ),
            searchBar.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    private func setupCollectionView() {
        
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(
            CarCategoryCollectionViewCell.self,
            forCellWithReuseIdentifier:
                CarCategoryCollectionViewCell.identifier
        )
        collectionView.register(
            VehicleCollectionViewCell.self,
            forCellWithReuseIdentifier: VehicleCollectionViewCell.identifier
        )
        
        NSLayoutConstraint.activate([
             collectionView.topAnchor.constraint(
                equalTo: searchBar.bottomAnchor, constant: -10
             ),
             collectionView.leadingAnchor.constraint(
                 equalTo: view.leadingAnchor
             ),
             collectionView.trailingAnchor.constraint(
                 equalTo: view.trailingAnchor
             ),
             collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
         ])
    }
    
    
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewLayout()
        )
        
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    private func loadCars() {
        cars = CarDataService.shared.loadCars()
        
        categories = Array(
            Set(cars.map {$0.category})
        ).sorted()
        
        print("Cars:", cars.count)
        print("categories:", categories)
        collectionView.reloadData()
    }
    
    
}


extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return categories.count
        } else {
            return cars.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath
    ){
        
        selectedCategoryIndex = indexPath.item
        
        collectionView.reloadData()
    }
}
