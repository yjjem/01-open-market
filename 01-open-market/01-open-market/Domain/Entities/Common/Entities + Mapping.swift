//
//  Entities + Mapping.swift
//  01-open-market
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit

extension ProductListResponse {
    func asProducts() -> [ProductResponse] {
        return self.pages
    }
}

extension ProductResponse {
    func asPostProduct() -> PostableProduct {
        return PostableProduct(
            identifier: self.identifier,
            name: self.name,
            price: self.price,
            discount: self.discountedPrice,
            currency: self.currency,
            stock: self.stock,
            description: self.description
        )
    }
    
    func asProductCellViewModel() -> ProductCellViewModel {
        return ProductCellViewModel(
            identifier: self.identifier,
            name: self.name,
            price: self.price,
            discount: self.discountedPrice,
            currency: self.currency,
            stock: self.stock,
            thumbnail: self.thumbnail,
            description: self.description
        )
    }
}
