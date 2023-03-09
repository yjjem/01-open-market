//
//  Product.swift
//  01-open-market
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import Foundation

struct ProductResponse: Decodable, Hashable {
    let identifier: Int
    let vendorIdentifier: Int
    let name: String
    let thumbnail: String
    let currency: Currency
    let price: Double
    let bargainPrice: Double
    let discountedPrice: Double
    let stock: Int
    let createdDate: String
    let issuedDate: String
    let vendorName: String
    let description: String
    let uuid: UUID = UUID()
    
    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case vendorIdentifier = "vendorId"
        case name
        case thumbnail
        case currency
        case price
        case bargainPrice
        case discountedPrice
        case stock
        case createdDate = "createdAt"
        case issuedDate = "issuedAt"
        case vendorName
        case description
    }
}
