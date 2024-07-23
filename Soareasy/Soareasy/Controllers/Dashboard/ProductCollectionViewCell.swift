//
//  ProductCollectionViewCell.swift
//  Soareasy
//
//  Created by Cynthia D'Phoenix on 7/23/24.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let buyButton = UIButton(type: .system)
    
    var products: Product?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.backgroundColor = .white
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true

        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)

        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)

        priceLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        priceLabel.textColor = .black
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(priceLabel)

        buyButton.setTitle("Buy", for: .normal)
        buyButton.backgroundColor = .systemPurple
        buyButton.setTitleColor(.white, for: .normal)
        buyButton.layer.cornerRadius = 4
        buyButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(buyButton)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            imageView.heightAnchor.constraint(equalToConstant: 140),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),

            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            priceLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
//            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),

            buyButton.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
            buyButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            buyButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            buyButton.heightAnchor.constraint(equalToConstant: 30),
            buyButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    func configure(with product: Product) {
        imageView.image = UIImage(named: product.imageName)
        titleLabel.text = product.title
        priceLabel.text = product.price
    }
}

