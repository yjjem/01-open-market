//
//  Entities + Mapping.swift
//  01-open-market
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import Foundation

extension ProductListResponse {
    func asProducts() -> [ProductResponse] {
        return self.pages
    }
}

extension ProductResponse {
    func asPostProduct() -> PostProduct {
        return PostProduct(
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
