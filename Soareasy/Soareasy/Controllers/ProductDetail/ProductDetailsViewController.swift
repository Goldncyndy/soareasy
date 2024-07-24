//
//  ProductDetailsViewController.swift
//  Soareasy
//
//  Created by Cynthia D'Phoenix on 7/23/24.
//

import UIKit


class ProductDetailsViewController: UIViewController {
    
    private let pageTitleLabel = UILabel()
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel() // New description label
    private let priceLabel = UILabel()
    private let discountedPriceLabel = UILabel()
    private let buyButton = UIButton(type: .system)
    private let addToCartButton = UIButton(type: .system)
    
    var product: Product?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        configureView()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        
        // Page Title Label Setup
        pageTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        pageTitleLabel.textColor = .black
        pageTitleLabel.numberOfLines = 0
        pageTitleLabel.textAlignment = .center
        pageTitleLabel.text = "Product Detail"
        pageTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pageTitleLabel)

        // Image View Setup
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)

        // Title Label Setup
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        // Description Label Setup
        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        descriptionLabel.textColor = .darkGray
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionLabel)

        // Price Label Setup
        priceLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        priceLabel.textColor = .black
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(priceLabel)

        // Discounted Price Label Setup
        discountedPriceLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        discountedPriceLabel.textColor = .red
        discountedPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(discountedPriceLabel)
        
        // Buy Button Setup
        buyButton.setTitle("Checkout", for: .normal)
        buyButton.backgroundColor = .systemPurple
        buyButton.setTitleColor(.white, for: .normal)
        buyButton.layer.cornerRadius = 4
        buyButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buyButton)
        
        // Add to Cart Button Setup
        addToCartButton.setTitle("Add to Cart", for: .normal)
        addToCartButton.backgroundColor = .black
        addToCartButton.setTitleColor(.white, for: .normal)
        addToCartButton.layer.cornerRadius = 4
        addToCartButton.translatesAutoresizingMaskIntoConstraints = false
        addToCartButton.addTarget(self, action: #selector(addToCartButtonTapped), for: .touchUpInside)
        view.addSubview(addToCartButton)

        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Page Title Label Constraints
            pageTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            pageTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            // Image View Constraints
            imageView.topAnchor.constraint(equalTo: pageTitleLabel.bottomAnchor, constant: 60),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalToConstant: 250),

            // Title Label Constraints
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            // Description Label Constraints
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Price Label Constraints
            priceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 140),
            
            // Discounted Price Label Constraints
            discountedPriceLabel.topAnchor.constraint(equalTo: priceLabel.topAnchor),
            discountedPriceLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 30),
//            discountedPriceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            // Buy Button Constraints
            buyButton.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 30),
            buyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buyButton.heightAnchor.constraint(equalToConstant: 50),
            buyButton.widthAnchor.constraint(equalToConstant: view.frame.width/2 - 23),

            // Add to Cart Button Constraints
            addToCartButton.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 30),
            addToCartButton.leadingAnchor.constraint(equalTo: buyButton.trailingAnchor, constant: 10),
            addToCartButton.heightAnchor.constraint(equalToConstant: 50),
            addToCartButton.widthAnchor.constraint(equalToConstant: view.frame.width/2 - 23)
        ])
    }

    private func configureView() {
        guard let product = product else { return }
        imageView.image = UIImage(named: product.imageName)
        titleLabel.text = "E-book: " + product.title
        descriptionLabel.text = product.description
        priceLabel.text = "₦\(product.price)"
        discountedPriceLabel.text = "₦\(product.discountPrice)"
    }
    
    @objc func addToCartButtonTapped() {
        guard let product = product else { return }
        
        // Add the product to the shared cart
        Cart.shared.addProduct(product)
        
        let cartViewController = CartViewController()
        cartViewController.modalPresentationStyle = .fullScreen
        present(cartViewController, animated: true, completion: nil)
    }
}

