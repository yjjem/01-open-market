//
//  URLSessionProtocol.swift
//  01-open-market
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import Foundation

protocol URLSessionProtocol {
    
    func dataTask(
        with request: URLRequest,
        completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol { }
