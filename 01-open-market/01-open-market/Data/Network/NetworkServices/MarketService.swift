//
//  MarketService.swift
//  01-open-market
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import Foundation

final class MarketService: MarketServiceType {
    private let network: NetworkProvider
    
    init(network: NetworkProvider = .init()) {
        self.network = network
    }
    
    func retrieveProductList(
        parameters: ProductListRequest,
        completion: @escaping (Result<ProductList, NetworkError>) -> Void
    ) -> URLSessionDataTask? {
        return network.request(parameters: parameters, completion: completion)
    }
}

