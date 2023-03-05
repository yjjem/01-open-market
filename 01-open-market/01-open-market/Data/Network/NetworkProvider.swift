//
//  NetworkProvider.swift
//  01-open-market
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import Foundation

final class NetworkProvider {
    private let session: URLSession
    private let queue: DispatchQueue
    
    init(session: URLSession = .shared, queue: DispatchQueue = .global()) {
        self.session = session
        self.queue = queue
    }
    
    func request<P: Requestable>(
        parameters: P,
        completion: @escaping ((Result<P.Response, NetworkError>) -> Void)
    ) -> URLSessionDataTask? {
        guard let request = parameters.urlRequest else { return nil }
        let dataTask = session.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(.failure(.requestFailed))
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode)
            else {
                return completion(.failure(.serverProblem))
            }
            guard let data = data else {
                return completion(.failure(.missingData))
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let data = try decoder.decode(P.Response.self, from: data)
                return completion(.success(data))
            } catch {
                return completion(.failure(.decodeFailed))
            }
        }
        dataTask.resume()
        return dataTask
    }
}
