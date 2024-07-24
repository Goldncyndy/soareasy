//
//  ProductCollectionViewCell.swift
//  Soareasy
//
//  Created by Cynthia D'Phoenix on 7/23/24.
//

import UIKit

protocol ProductCollectionViewCellDelegate: AnyObject {
    func productCollectionViewCell(_ cell: ProductCollectionViewCell, didTapAddToCartFor product: Product)
}

class ProductCollectionViewCell: UICollectionViewCell {
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let buyButton = UIButton(type: .system)
    
    var products: Product?
    weak var delegate: ProductCollectionViewCellDelegate?

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

        buyButton.setTitle("Add to Cart", for: .normal)
        buyButton.backgroundColor = .systemPurple
        buyButton.setTitleColor(.white, for: .normal)
        buyButton.layer.cornerRadius = 4
        buyButton.addTarget(self, action: #selector(addToCartButtonTapped), for: .touchUpInside)
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
        priceLabel.text = "₦\(product.price)"
        self.products = product
    }
    
    @objc func addToCartButtonTapped() {
           guard let product = products else { return }
           delegate?.productCollectionViewCell(self, didTapAddToCartFor: product)
       }
    
//    @objc func addToCartButtonTapped() {
//         guard let product = products else { return }
//         Cart.shared.addProduct(product)
//         NotificationCenter.default.post(name: .cartUpdated, object: nil)
//     }
 }

 extension Notification.Name {
     static let cartUpdated = Notification.Name("cartUpdated")
 }

