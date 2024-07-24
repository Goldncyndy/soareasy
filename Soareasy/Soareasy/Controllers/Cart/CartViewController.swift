//
//  CartViewController.swift
//  Soareasy
//
//  Created by Cynthia D'Phoenix on 7/23/24.
//

import UIKit

import UIKit

class CartViewController: UIViewController {
    
    private let pageTitleLabel = UILabel()
    private var collectionView: UICollectionView!
    private let totalAmountLabel = UILabel()
    private let vatLabel = UILabel()
    private let buyButton = UIButton(type: .system)
    private let closeButton = UIButton(type: .system)
    
    private var products: [Product] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        products = Cart.shared.products
        setupViews()
        updatePriceLabels()
    }
    
    private func setupViews() {
        // Page Title Label Setup
        pageTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        pageTitleLabel.textColor = .black
        pageTitleLabel.numberOfLines = 0
        pageTitleLabel.textAlignment = .center
        pageTitleLabel.text = "Cart"
        pageTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pageTitleLabel)

        // Total Amount Label Setup
        totalAmountLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        totalAmountLabel.textColor = .black
        totalAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(totalAmountLabel)

        // VAT Label Setup
        vatLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        vatLabel.textColor = .darkGray
        vatLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(vatLabel)

        // Checkout and Buy Button Setup
        buyButton.setTitle("Checkout", for: .normal)
        buyButton.backgroundColor = .systemPurple
        buyButton.setTitleColor(.white, for: .normal)
        buyButton.layer.cornerRadius = 4
        buyButton.translatesAutoresizingMaskIntoConstraints = false
        buyButton.addTarget(self, action: #selector(buyButtonTapped), for: .touchUpInside)
        view.addSubview(buyButton)
        
        // Close Button Setup
        closeButton.setTitle("Close", for: .normal)
        closeButton.backgroundColor = .black
        closeButton.setTitleColor(.white, for: .normal)
        closeButton.layer.cornerRadius = 4
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        view.addSubview(closeButton)
        
        // Collection View
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CartCollectionViewCell.self, forCellWithReuseIdentifier: "CartCell")
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
     
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Page Title Label Constraints
            pageTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            pageTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Collection View Constraints
            collectionView.topAnchor.constraint(equalTo: pageTitleLabel.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 500), // Adjust this later dynamically
            
            // Total Amount Label Constraints
            totalAmountLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
            totalAmountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            // VAT Label Constraints
            vatLabel.topAnchor.constraint(equalTo: totalAmountLabel.bottomAnchor, constant: 10),
            vatLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            // Buy Button Constraints
            buyButton.topAnchor.constraint(equalTo: vatLabel.bottomAnchor, constant: 30),
            buyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buyButton.heightAnchor.constraint(equalToConstant: 50),
            buyButton.widthAnchor.constraint(equalToConstant: view.frame.width / 2 - 23),
            
            // Close Button Constraints
            closeButton.topAnchor.constraint(equalTo: vatLabel.bottomAnchor, constant: 30),
            closeButton.leadingAnchor.constraint(equalTo: buyButton.trailingAnchor, constant: 10),
            closeButton.heightAnchor.constraint(equalToConstant: 50),
            closeButton.widthAnchor.constraint(equalToConstant: view.frame.width / 2 - 23),
        ])
    }
    
    private func updatePriceLabels() {
        let totalAmount = Cart.shared.totalAmount()
        let vat = Cart.shared.vatAmount()
        totalAmountLabel.text = "Total: ₦\(String(format: "%.2f", totalAmount))"
        vatLabel.text = "VAT (7.5%): ₦\(String(format: "%.2f", vat))"
    }
    
    @objc func closeButtonTapped() {
        
        let dashboardVC = DashboardViewController()
        dashboardVC.modalPresentationStyle = .fullScreen
        present(dashboardVC, animated: true, completion: nil)
        
    }
    
    @objc func buyButtonTapped() {
        let dashboardVC = DashboardViewController()
        navigationController?.pushViewController(dashboardVC, animated: true)
        
    }
}

extension CartViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CartCell", for: indexPath) as? CartCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let product = products[indexPath.row]
        cell.configure(with: product)
        return cell
    }

    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 10
        let itemWidth = (collectionView.frame.width - padding * 2)
        return CGSize(width: itemWidth, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = products[indexPath.row]
        
        let productDetailsViewController = ProductDetailsViewController()
        productDetailsViewController.product = product
        
        navigationController?.pushViewController(productDetailsViewController, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, didChangeContentSize newContentSize: CGSize) {
        let maxHeight: CGFloat = 600
        let newHeight = min(newContentSize.height, maxHeight)
        collectionView.heightAnchor.constraint(equalToConstant: newHeight).isActive = true
        view.layoutIfNeeded()
    }
}



