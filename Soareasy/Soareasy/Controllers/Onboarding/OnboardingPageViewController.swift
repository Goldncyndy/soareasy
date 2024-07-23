//
//  OnboardingViewController.swift
//  Soareasy
//
//  Created by Cynthia D'Phoenix on 7/22/24.
//

import UIKit

class OnboardingPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var pages = [UIViewController]()
    let pageControl = UIPageControl()
    let skipButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self
        
        let page1 = OnboardingContentViewController(imageName: "onboard2", titleText: "Welcome to Soareasy", descriptionText: "Discover a world of digital products at your fingertips. From eBooks to software, find everything you need in one place.")
        let page2 = OnboardingContentViewController(imageName: "onboard4", titleText: "Seamless Shopping Experience", descriptionText: "Enjoy a user-friendly interface and secure payment options. Shopping for digital products has never been easier.")
        let page3 = OnboardingContentViewController(imageName: "onboard1", titleText: "Instant Access", descriptionText: "Get instant access to your purchases right after checkout. No waiting, just download and start using your digital products immediately.")
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        setViewControllers([pages[0]], direction: .forward, animated: true, completion: nil)
        
        setupPageControl()
        setupSkipButton()
    }

    func setupPageControl() {
        pageControl.frame = CGRect()
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor.gray
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setupSkipButton() {
        skipButton.setTitle("Skip", for: .normal)
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        skipButton.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        view.addSubview(skipButton)
        
        NSLayoutConstraint.activate([
            skipButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
//    @objc func skipButtonTapped() {
//        let signupViewController = SignupViewController()
//        navigationController?.pushViewController(signupViewController, animated: true)
//    }
    
    @objc func skipButtonTapped() {
            let signinVC = SignInViewController()
            signinVC.modalPresentationStyle = .fullScreen
            present(signinVC, animated: true, completion: nil)
        }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController) else { return nil }
        let previousIndex = index - 1
        return previousIndex >= 0 ? pages[previousIndex] : nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController) else { return nil }
        let nextIndex = index + 1
        return nextIndex < pages.count ? pages[nextIndex] : nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            guard let currentViewController = pageViewController.viewControllers?.first,
                  let currentIndex = pages.firstIndex(of: currentViewController) else {
                return
            }
            pageControl.currentPage = currentIndex
        }
    }
}


