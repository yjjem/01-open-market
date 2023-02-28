//
//  EndPoint.swift
//  01-open-market
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import Foundation

struct EndPoint {
    private let host: String
    private let path: String
    private let parameters: [String: String]
    
    init(host: String, path: String, parameters: [String : String]) {
        self.host = host
        self.path = path
        self.parameters = parameters
    }
    
    var url: URL? {
        var components = URLComponents(string: host)
        components?.path = path
        components?.queryItems = parameters.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        return components?.url
    }
}
