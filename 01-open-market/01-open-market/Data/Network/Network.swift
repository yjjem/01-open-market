//
//  Network.swift
//  01-open-market
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import Foundation

final class Network<Response: Decodable>: Requestable {
    private let session: URLSessionProtocol
    private let host: String
    private let queue: DispatchQueue
    
    init(
        host: String,
        session: URLSessionProtocol = URLSession.shared,
        queue: DispatchQueue = .global()
    ) {
        self.host = host
        self.session = session
        self.queue = queue
    }
    
    func request(endPoint: EndPoint, handler: @escaping (Result<Response, Error>) -> Void) {
        guard let url = endPoint.url else { return }
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { data, response, error in
            guard error != nil else {
                handler(.failure(NetworkError.exampleError))
                return
            }
        }
        task.resume()
    }
}

protocol Requestable {
    associatedtype Response
    
    func request(endPoint: EndPoint, handler: @escaping (Result<Response, Error>) -> Void)
}
