//
//  ProductList.swift
//  01-open-market
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import Foundation

struct ProductList: Decodable {
    let pageNumber: Int
    let itemsPerPage: Int
    let totalCount: Int
    let offset: Int
    let limit: Int
    var pages: [Product]
    let lastPage: Int
    let hasNext: Bool
    let hasPrevious: Bool
    
    private enum CodingKeys: String, CodingKey {
        case pageNumber = "pageNo"
        case itemsPerPage = "itemsPerPage"
        case totalCount = "totalCount"
        case offset
        case limit
        case pages
        case lastPage = "lastPage"
        case hasNext = "hasNext"
        case hasPrevious = "hasPrev"
    }
}
