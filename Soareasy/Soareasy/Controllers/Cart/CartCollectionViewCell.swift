//
//  CartCollectionViewCell.swift
//  Soareasy
//
//  Created by Cynthia D'Phoenix on 7/23/24.
//

import UIKit

protocol CartCollectionViewCellDelegate: AnyObject {
    func cartCollectionViewCell( _ cell: CartCollectionViewCell, didTapRemoveFromCartFor product: Product)
}

class CartCollectionViewCell: UICollectionViewCell {
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let removeButton = UIButton(type: .system)
    
    var products: Product?
    weak var delegate: CartCollectionViewCellDelegate?

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

        removeButton.setTitle("Remove from Cart", for: .normal)
        removeButton.backgroundColor = .systemPurple
        removeButton.setTitleColor(.white, for: .normal)
        removeButton.layer.cornerRadius = 4
        removeButton.addTarget(self, action: #selector(removeItemFromCartButtonTapped), for: .touchUpInside)
        removeButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(removeButton)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            imageView.heightAnchor.constraint(equalToConstant: 110),
            imageView.widthAnchor.constraint(equalToConstant: 90),

            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15),
//            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            priceLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15),

            removeButton.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
            removeButton.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15),
            removeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            removeButton.heightAnchor.constraint(equalToConstant: 40),
            removeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    func configure(with product: Product) {
        imageView.image = UIImage(named: product.imageName)
        titleLabel.text = product.title
        priceLabel.text = "₦\(product.price)"
        self.products = product
    }
    
    @objc func removeItemFromCartButtonTapped() {
        guard let product = products else { return }
        delegate?.cartCollectionViewCell(self, didTapRemoveFromCartFor: product)
    }
}
