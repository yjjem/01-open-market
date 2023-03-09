//
//  PostProduct.swift
//  01-open-market
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import Foundation

struct PostableProduct  {
    let identifier: Int
    let name: String
    let price: Double
    let discount: Double
    let currency: Currency
    let stock: Int
    let description: String
}
