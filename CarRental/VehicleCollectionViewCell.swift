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
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 35)
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
        label.font = .systemFont(ofSize: 35, weight: .thin)
        label.textColor = .blue
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
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let engineLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
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
            
            brandLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 40),
            brandLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 30),
            
            modelLabel.topAnchor.constraint(equalTo: brandLabel.bottomAnchor, constant: 4),
            modelLabel.leadingAnchor.constraint(equalTo: brandLabel.leadingAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 40),
            priceLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -30),
            
            periodLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 4),
            periodLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -30),
            
            engineTitleLabel.topAnchor.constraint(equalTo: modelLabel.bottomAnchor, constant: 8),
            engineTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
        
            engineLabel.topAnchor.constraint(equalTo: periodLabel.bottomAnchor, constant: 8),
            engineLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -30),
            
            carImageView.topAnchor.constraint(equalTo: engineLabel.bottomAnchor),
            carImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 30),
            carImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -30),
            carImageView.heightAnchor.constraint(equalToConstant: 200)
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
