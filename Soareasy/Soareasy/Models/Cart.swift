//
//  Cart.swift
//  Soareasy
//
//  Created by Cynthia D'Phoenix on 7/23/24.
//

import Foundation

class Cart {
    static let shared = Cart()
    private(set) var products = [Product]()
    
    private init() {}
    
    func addProduct(_ product: Product) {
        products.append(product)
    }
    
    func removeProduct(_ product: Product) {
        if let index = products.firstIndex(where: { $0.id == product.id }) {
           products.remove(at: index)
         }
     }
    
    func totalAmount() -> Double {
        return products.reduce(0) { $0 + $1.price }
    }
    
    func vatAmount() -> Double {
        return totalAmount() * 0.075
    }
    
    func totalWithVAT() -> Double {
        return totalAmount() + vatAmount()
    }
    
    func getProducts() -> [Product] {
        return products
    }

    func getTotalItems() -> Int {
        return products.count
    }
}

