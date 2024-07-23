//
//  DashProductViewModel.swift
//  Soareasy
//
//  Created by Cynthia D'Phoenix on 7/23/24.
//

import Foundation


class ProductViewModel {
    private var products: [Product]

    init(products: [Product]) {
        self.products = products
    }

    func numberOfItems() -> Int {
        return products.count
    }

    func product(at index: Int) -> Product {
        return products[index]
    }
}
