//
//  ProductCellViewModel.swift
//  01-open-market
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import Foundation

struct ProductCellViewModel {
    let name: String
    let price: Double
    let discount: Double
    let currency: Currency
    let stock: Int
    let thumbnail: String
    let description: String
}

extension ProductCellViewModel {
    func asPostProduct() -> PostProduct {
        return PostProduct(
            name: self.name,
            price: self.price,
            discount: self.discount,
            currency: self.currency,
            stock: self.stock,
            description: self.description
        )
    }
}
