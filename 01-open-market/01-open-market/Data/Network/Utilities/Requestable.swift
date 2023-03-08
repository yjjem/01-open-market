//
//  Requestable.swift
//  01-open-market
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import Foundation

protocol Requestable {
    associatedtype Response: Decodable
    
    var host: URL? { get }
    var path: String { get }
    var queries: [String: String] { get }
    var headers: [String: String]? { get }
    var method: HTTPMethod { get }
    var url: URL? { get }
}

extension Requestable {
    var url: URL? {
        var components = host.flatMap { URLComponents(string: $0.absoluteString) }
        components?.queryItems = queries.map { URLQueryItem(name: $0, value: $1)}
        components?.path = path
        return components?.url
    }
    var urlRequest: URLRequest? {
        guard let url = url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method.name
        return request
    }
}

struct ProductListRequest: Requestable {
    typealias Response = ProductListResponse
    
    let pageNumber: Int
    let searchValue: String? = nil
    let itemsLimit: Int = 20
    var method: HTTPMethod = .get
    var headers: [String : String]? = nil
    
    var host: URL? {
        return URL(string: "https://openmarket.yagom-academy.kr")
    }
    var path: String {
        return "/api/products"
    }
    var queries: [String : String] {
        return [
            "page_no" : "\(pageNumber)",
            "items_per_page" : "\(itemsLimit)"
        ]
    }
}
