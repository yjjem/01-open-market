//
//  EndPoint.swift
//  01-open-market
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import Foundation

struct EndPoint {
    private let parameters: Parameters
    
    var url: URL? {
        var components = URLComponents(string: Host.market)
        components?.path = parameters.path
        components?.queryItems = parameters.queryItems
        return components?.url
    }
    
    init(parameters: Parameters) {
        self.parameters = parameters
    }
}

extension EndPoint {
    enum Parameters {
        case productList(pageNumber: Int, itemsPerPage: Int, searchValue: String?)
        case productDetails(productIdentifier: Int)
        
        fileprivate var path: String {
            switch self {
            case .productList(_, _, _):
                return Path.APIProduct
            case .productDetails(let id):
                return Path.APIProduct + "/\(id)"
            }
        }
        
        fileprivate var queryItems: [URLQueryItem] {
            switch self {
            case .productList(let pageNumber, let itemsPerPage, let searchValue):
                var items =  [
                    URLQueryItem(name: QueryNames.pageNumber, value: String(pageNumber)),
                    URLQueryItem(name: QueryNames.itemsPerPage, value: String(itemsPerPage))
                ]
                if searchValue != nil {
                    let searchItem = URLQueryItem(name: QueryNames.searchValue, value: searchValue)
                    items.append(searchItem)
                }
                return items
            case .productDetails(_): return []
            }
        }
    }
    
    enum Host {
        static let market = "https://openmarket.yagom-academy.kr"
    }
    
    enum Path {
        static let APIProduct = "/api/products"
    }
    
    enum QueryNames {
        static let pageNumber = "page_no"
        static let itemsPerPage = "items_per_page"
        static let searchValue = "searchValue"
        static let productIdentifier = "product_id"
    }
}
