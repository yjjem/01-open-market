//
//  NetworkManager.swift
//  01-open-market
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import Foundation
import RxSwift

final class NetworkManager {
    private let session: URLSessionProtocol
    private let queue: DispatchQueue
    
    init(session: URLSessionProtocol = URLSession.shared, queue: DispatchQueue = .global()) {
        self.session = session
        self.queue = queue
    }
    
    func request(endPoint: EndPoint) -> Observable<Data> {
        guard let url = endPoint.url else {
            return Observable.error(NetworkError.badURL)
        }
        return Observable.create { [weak self] emitter in
            let request = URLRequest(url: url)
            let dataTask = self?.session.dataTask(with: request) { data, response, error in
                guard error == nil else {
                    emitter.onError(NetworkError.requestFailed)
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode)
                else {
                    emitter.onError(NetworkError.serverProblem)
                    return
                }
                guard let data = data else {
                    emitter.onError(NetworkError.missingData)
                    return
                }
                emitter.onNext(data)
                emitter.onCompleted()
            }
            dataTask?.resume()

            return Disposables.create {
                dataTask?.cancel()
            }
        }
    }
}
