//
//  CheckoutViewController.swift
//  Soareasy
//
//  Created by Cynthia D'Phoenix on 7/24/24.
//

import UIKit


class CheckoutViewController: UIViewController {
    
    private let pageTitleLabel = UILabel()
    private var collectionView: UICollectionView!
    private var products = [Product]()
    private let totalAmountLabel = UILabel()
    private let checkoutButton = UIButton(type: .system)
    private let backButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Checkout"
        view.backgroundColor = .white
        products = Cart.shared.getProducts()
        setupViews()
        updateTotalAmount()
    }
    
    private func setupViews() {
        
        // Page Title Label Setup
        pageTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        pageTitleLabel.textColor = .black
        pageTitleLabel.numberOfLines = 0
        pageTitleLabel.textAlignment = .center
        pageTitleLabel.text = "Checkout"
        pageTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pageTitleLabel)
        
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
        
        totalAmountLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        totalAmountLabel.textColor = .black
        totalAmountLabel.textAlignment = .right
        totalAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(totalAmountLabel)
        
        checkoutButton.setTitle("Checkout", for: .normal)
        checkoutButton.backgroundColor = .systemGreen
        checkoutButton.setTitleColor(.white, for: .normal)
        checkoutButton.layer.cornerRadius = 4
        checkoutButton.translatesAutoresizingMaskIntoConstraints = false
        checkoutButton.addTarget(self, action: #selector(checkoutButtonTapped), for: .touchUpInside)
        view.addSubview(checkoutButton)
        
        // Close Button Setup
        backButton.setTitle("Go back", for: .normal)
        backButton.backgroundColor = .black
        backButton.setTitleColor(.white, for: .normal)
        backButton.layer.cornerRadius = 4
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            
            // Page Title Label Constraints
            pageTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            pageTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            collectionView.topAnchor.constraint(equalTo: pageTitleLabel.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: totalAmountLabel.topAnchor, constant: -20),
            
            totalAmountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            totalAmountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            totalAmountLabel.bottomAnchor.constraint(equalTo: checkoutButton.topAnchor, constant: -20),
            
            checkoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            checkoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            checkoutButton.bottomAnchor.constraint(equalTo: backButton.topAnchor, constant: -20),
            checkoutButton.heightAnchor.constraint(equalToConstant: 50),
            
            // Close Button Constraints
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            backButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            backButton.heightAnchor.constraint(equalToConstant: 50),

        ])
    }
    
    private func updateTotalAmount() {
        let totalAmount = products.reduce(0) { $0 + $1.price }
//        totalAmountLabel.text = "Total: ₦\(totalAmount)"
        let totalAmt = Cart.shared.totalAmount()
        totalAmountLabel.text = "Total: ₦\(String(format: "%.2f", totalAmt))"
    }
    
    @objc private func checkoutButtonTapped() {
        let alert = UIAlertController(title: "Checkout", message: "Proceed to payment?", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Yes", style: .default) { _ in
            // Handle checkout logic here
            Cart.shared.clearCart()
            let cartViewController = PaymentViewController()
            cartViewController.modalPresentationStyle = .fullScreen
            self.present(cartViewController, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func closeButtonTapped() {

        let dashboardVC = CartViewController()
        dashboardVC.modalPresentationStyle = .fullScreen
        present(dashboardVC, animated: true, completion: nil)

    }
}

extension CheckoutViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CartCell", for: indexPath) as? CartCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let product = products[indexPath.row]
        cell.configure(with: product)
        cell.delegate = self
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 10
        let itemWidth = (collectionView.frame.width - padding * 2)
        return CGSize(width: itemWidth, height: 130)
    }
}

extension CheckoutViewController: CartCollectionViewCellDelegate {
    func cartCollectionViewCell(_ cell: CartCollectionViewCell, didTapRemoveFromCartFor product: Product) {
        Cart.shared.removeProduct(product)
        products = Cart.shared.getProducts()
        collectionView.reloadData()
        updateTotalAmount()
        NotificationCenter.default.post(name: .cartUpdated, object: nil)
    }
}
