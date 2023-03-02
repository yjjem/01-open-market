//
//  ProductImage.swift
//  01-open-market
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import Foundation

struct ProductImage: Decodable, Hashable {
    let identifier: Int
    let url: String
    let thumbnailUrl: String
    let issuedDate: String
    
    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case url
        case thumbnailUrl
        case issuedDate = "issuedAt"
    }
}
