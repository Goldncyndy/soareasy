//
//  DashboardViewController.swift
//  Soareasy
//
//  Created by Cynthia D'Phoenix on 7/23/24.
//

import UIKit

class DashboardViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private let topView = UIView()
    private let profileImageView = UIImageView()
    private let cartIconImageView = UIImageView()
    private let bottomBannerView = UIView()
    private let bottomBannerImageView = UIImageView()
    private let bottomBannerLabel = UILabel()
    private var collectionView: UICollectionView!
    
    private var viewModel: ProductViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupViewModel()
    }
    
    private func setupViewModel() {

           let products = [
            Product(imageName: "product_image", title: "Digital Entrepreneur", price: "₦4,000", description: "Digital Entrepreneur is an E-book that teaches how to to start and run a successful online business", discountPrice: "₦7,000"),
            Product(imageName: "comeback_image", title: "Comeback Phoenix", price: "₦3,000", description: "Rise from adversity and become even better than you've ever been", discountPrice: "₦5,000"),
            Product(imageName: "product_image1", title: "Transition To Tech", price: "₦3,500", description: "Learn Javascript from scratch even as a complete beginner. Join the tech gurus and change your life.", discountPrice: "₦5,000"),
            Product(imageName: "product_image3", title: "How to start a Business", price: "₦4,000", description: "How to start and run a business. Become a business man/woman", discountPrice: "₦5,500"),
            Product(imageName: "product_image4", title: "Graphics Design", price: "₦3,000", description: "Learn and master graphic design tricks and start earning instantly.", discountPrice: "₦5,500"),
            Product(imageName: "product_image", title: "Digital Entrepreneur", price: "₦4,000", description: "This is an E-book that teaches how to to start and run a successful online business", discountPrice: "₦6,500"),
            Product(imageName: "product_image2", title: "Comeback Phoenix", price: "₦3,000", description: "You can Rise from adversity and become even better than you've ever been", discountPrice: "₦5000"),
            Product(imageName: "product_image1", title: "Transition To Tech", price: "₦3,500", description: "Learn Javascript from scratch even as a complete beginner. Join the tech gurus and change your life.", discountPrice: "₦5,500"),
            Product(imageName: "product_image3", title: "How to start a Business", price: "₦4,000", description: "How to start and run a business. Become a business man/woman", discountPrice: "₦5,500"),
            Product(imageName: "product_image4", title: "Graphics Design", price: "₦3,000", description: "Learn and master graphic design tricks and start earning instantly.", discountPrice: "₦5,700"),
            Product(imageName: "product_image", title: "Digital Entrepreneur", price: "₦4,000", description: "An E-book that teaches how to to start and run a successful online business", discountPrice: "₦6,000"),
            Product(imageName: "comeback_image", title: "Comeback Phoenix", price: "₦3,000", description: "Rise from adversity and become even better than you've ever been", discountPrice: "₦5,500"),
            Product(imageName: "product_image1", title: "Transition To Tech", price: "₦3,500", description: "Learn Javascript from scratch even as a complete beginner. Join the tech gurus and change your life.", discountPrice: "₦4,000"),
            Product(imageName: "product_image3", title: "How to start a Business", price: "₦4,000", description: "How to start and run a business. Become a business man/woman", discountPrice: "₦7,000"),
           ]
        
       viewModel = ProductViewModel(products: products)
       }

    private func setupViews() {
        view.backgroundColor = .black

        // Top View
        topView.backgroundColor = .systemPurple
        view.addSubview(topView)

        // Profile Image View
        profileImageView.image = UIImage(named: "profile_image") // Replace with your profile image name
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 20
        profileImageView.clipsToBounds = true
        topView.addSubview(profileImageView)

        // Cart Icon Image View
        cartIconImageView.image = UIImage(systemName: "cart.fill")
        cartIconImageView.tintColor = .white
        topView.addSubview(cartIconImageView)

        // Bottom Banner View
        bottomBannerView.backgroundColor = .black
        view.addSubview(bottomBannerView)

        // Bottom Banner Image View
        bottomBannerImageView.image = UIImage(named: "banner_image") // Replace with your banner image name
        bottomBannerImageView.contentMode = .scaleToFill
        bottomBannerView.addSubview(bottomBannerImageView)

        // Bottom Banner Label
        bottomBannerLabel.text = "Special Offer"
        bottomBannerLabel.font = UIFont.boldSystemFont(ofSize: 18)
        bottomBannerLabel.textColor = .systemOrange
        bottomBannerView.addSubview(bottomBannerLabel)

        // Collection View
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: "ProductCell")
        collectionView.backgroundColor = .black
        view.addSubview(collectionView)
    }

    private func setupConstraints() {
        topView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        cartIconImageView.translatesAutoresizingMaskIntoConstraints = false
        bottomBannerView.translatesAutoresizingMaskIntoConstraints = false
        bottomBannerImageView.translatesAutoresizingMaskIntoConstraints = false
        bottomBannerLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // Top View Constraints
            topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 50),

            // Profile Image View Constraints
            profileImageView.widthAnchor.constraint(equalToConstant: 40),
            profileImageView.heightAnchor.constraint(equalToConstant: 40),
            profileImageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 16),
            profileImageView.centerYAnchor.constraint(equalTo: topView.centerYAnchor),

            // Cart Icon Image View Constraints
            cartIconImageView.widthAnchor.constraint(equalToConstant: 24),
            cartIconImageView.heightAnchor.constraint(equalToConstant: 24),
            cartIconImageView.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -16),
            cartIconImageView.centerYAnchor.constraint(equalTo: topView.centerYAnchor),

            // Bottom Banner View Constraints
            bottomBannerView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 2),
            bottomBannerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomBannerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomBannerView.heightAnchor.constraint(equalToConstant: 100),

            // Bottom Banner Image View Constraints
            bottomBannerImageView.leadingAnchor.constraint(equalTo: bottomBannerView.leadingAnchor),
            bottomBannerImageView.trailingAnchor.constraint(equalTo: bottomBannerView.trailingAnchor),
            bottomBannerImageView.topAnchor.constraint(equalTo: bottomBannerView.topAnchor),
            bottomBannerImageView.bottomAnchor.constraint(equalTo: bottomBannerView.bottomAnchor),
            bottomBannerImageView.heightAnchor.constraint(equalToConstant: bottomBannerView.frame.height),

            // Bottom Banner Label Constraints
            bottomBannerLabel.leadingAnchor.constraint(equalTo: bottomBannerImageView.trailingAnchor, constant: 16),
            bottomBannerLabel.centerYAnchor.constraint(equalTo: bottomBannerView.centerYAnchor),

            // Collection View Constraints
            collectionView.topAnchor.constraint(equalTo: bottomBannerView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfItems() ?? 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        guard let product = viewModel?.product(at: indexPath.row) else {
            return cell
        }
        
        cell.configure(with: product)
        return cell
    }


    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 10
        let itemWidth = (collectionView.frame.width - padding * 3) / 2
        return CGSize(width: itemWidth, height: itemWidth + 50)
    }
}

// MARK: - UICollectionViewDelegate

extension DashboardViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let product = viewModel?.product(at: indexPath.row) else { return }
        
        let productDetailsViewController = ProductDetailsViewController()
        productDetailsViewController.product = product
        
//        navigationController?.pushViewController(productDetailsViewController, animated: true)
        productDetailsViewController.modalPresentationStyle = .fullScreen
        present(productDetailsViewController, animated: true, completion: nil)
    }
}

