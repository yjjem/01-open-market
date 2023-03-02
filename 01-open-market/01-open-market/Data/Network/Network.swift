//
//  Network.swift
//  01-open-market
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import Foundation

final class Network: Requestable {
    private let session: URLSessionProtocol
    private let queue: DispatchQueue
    
    init(
        session: URLSessionProtocol = URLSession.shared,
        queue: DispatchQueue = .global()
    ) {
        self.session = session
        self.queue = queue
    }
    
    func request(endPoint: EndPoint, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = endPoint.url else {
            completion(.failure(.wrongURLFormat))
            return
        }
        print(url)
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(.failure(.requestFailed))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode)
            else {
                completion(.failure(.serverProblem))
                return
            }
            guard let data = data else {
                completion(.failure(.missingData))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
}

protocol Requestable {

    func request(endPoint: EndPoint, completion: @escaping (Result<Data, NetworkError>) -> Void)
}

