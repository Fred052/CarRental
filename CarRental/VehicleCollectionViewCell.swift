//
//  VehicleCollectionViewCell.swift
//  CarRental
//
//  Created by Ferid Suleymanzade on 31.07.26.
//

import UIKit

final class  VehicleCollectionViewCell: UICollectionViewCell {
    static let identifier = "VehicleCollectionViewCell"
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let carImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let brandLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let modelLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let periodLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let engineTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Engine"
        label.font = .systemFont(ofSize: 13)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let engineLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func  setupUI() {
        
        contentView.backgroundColor = .clear
        
        contentView.addSubview(containerView)
        
        containerView.addSubview(carImageView)
        containerView.addSubview(brandLabel)
        containerView.addSubview(modelLabel)
        containerView.addSubview(priceLabel)
        containerView.addSubview(periodLabel)
        containerView.addSubview(engineTitleLabel)
        containerView.addSubview(engineLabel)
        
        
        NSLayoutConstraint.activate([
            
            //Container
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            brandLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            brandLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            
            modelLabel.topAnchor.constraint(equalTo: brandLabel.bottomAnchor, constant: 4),
            modelLabel.leadingAnchor.constraint(equalTo: brandLabel.leadingAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            priceLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            engineTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            engineTitleLabel.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: -45),
            
            engineLabel.leadingAnchor.constraint(equalTo: engineTitleLabel.leadingAnchor),
            engineLabel.topAnchor.constraint(equalTo: engineTitleLabel.bottomAnchor, constant: 4),
            
            carImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            carImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            carImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            carImageView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    
    func configure(with car: Car) {
        brandLabel.text = car.brand
        modelLabel.text = car.model
        
        priceLabel.text = "$\(String(format: "%.0f", car.price))"
        periodLabel.text = "/ \(car.period)"
        
        engineLabel.text = car.engine
        
        carImageView.image = UIImage( named: car.image)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse( )
        
        carImageView.image = nil
        brandLabel.text = nil
        modelLabel.text = nil
        priceLabel.text = nil
        periodLabel.text = nil
        engineLabel.text = nil
    }
    
}
