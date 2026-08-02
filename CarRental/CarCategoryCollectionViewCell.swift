//
//  CarCategoryCollectionViewCell.swift
//  CarRental
//
//  Created by Ferid Suleymanzade on 31.07.26.
//

import UIKit

final class CarCategoryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CarCategoryCollectionViewCell"
    
    private let carImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let countLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        carImageView.image = nil
        categoryLabel.text = nil
        countLabel.text = nil
    }
    
    
    private func setupView() {
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 25
        contentView.clipsToBounds = false
        
        contentView.addSubview(carImageView)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(countLabel)
        
        
        NSLayoutConstraint.activate([
            carImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            carImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -30),
            carImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            carImageView.heightAnchor.constraint(equalToConstant: 100),
            
            categoryLabel.topAnchor.constraint(equalTo: carImageView.bottomAnchor),
            categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            
            countLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 5),
            countLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            countLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
        ])
    }
    
    func configure(
        image: UIImage,
        category: String,
        count: Int,
        isSelected: Bool = false
    ) {
        carImageView.image = image
        categoryLabel.text = category
        countLabel.text = "\(count)"
        
        if isSelected {
            contentView.backgroundColor = .systemBlue
            
            categoryLabel.textColor = .white
            countLabel.textColor = .white
        } else {
            contentView.backgroundColor = .systemBackground
            
            categoryLabel.textColor = .label
            countLabel.textColor = .secondaryLabel
        }
    }
    
    
}
