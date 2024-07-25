//
//  CheckoutViewController.swift
//  Soareasy
//
//  Created by Cynthia D'Phoenix on 7/24/24.
//

import UIKit

class CheckoutViewController: UIViewController {
    
    private let pageTitleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let backButton = UIButton(type: .system)
    private let logoutButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
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
        pageTitleLabel.text = "Checkout"
        pageTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pageTitleLabel)
        
        // Description Label Setup
        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        descriptionLabel.textColor = .darkGray
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        descriptionLabel.text = "Loading..."
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionLabel)
        
        // Logout Button Setup
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.backgroundColor = .systemPurple
        logoutButton.setTitleColor(.white, for: .normal)
        logoutButton.layer.cornerRadius = 4
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        view.addSubview(logoutButton)
        
        // Close Button Setup
        backButton.setTitle("Go back", for: .normal)
        backButton.backgroundColor = .black
        backButton.setTitleColor(.white, for: .normal)
        backButton.layer.cornerRadius = 4
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        view.addSubview(backButton)
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Page Title Label Constraints
            pageTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            pageTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Description Label Constraints
            descriptionLabel.topAnchor.constraint(equalTo: pageTitleLabel.bottomAnchor, constant: 150),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Buy Button Constraints
            logoutButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            logoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            logoutButton.heightAnchor.constraint(equalToConstant: 50),
            logoutButton.widthAnchor.constraint(equalToConstant: view.frame.width / 2 - 23),
            
            // Close Button Constraints
            backButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            backButton.leadingAnchor.constraint(equalTo: logoutButton.trailingAnchor, constant: 10),
            backButton.heightAnchor.constraint(equalToConstant: 50),
            backButton.widthAnchor.constraint(equalToConstant: view.frame.width / 2 - 23),
      
            
        ])
    }
    
    @objc func closeButtonTapped() {
        
        let dashboardVC = DashboardViewController()
        dashboardVC.modalPresentationStyle = .fullScreen
        present(dashboardVC, animated: true, completion: nil)
        
    }
    
    @objc func logoutButtonTapped() {
        let checkoutVC = SignInViewController()
        checkoutVC.modalPresentationStyle = .fullScreen
        present(checkoutVC, animated: true, completion: nil)
        
    }
}
