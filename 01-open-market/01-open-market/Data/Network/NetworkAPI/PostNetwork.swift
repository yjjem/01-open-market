//
//  PostNetwork.swift
//  01-open-market
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import Foundation

final class PostNetwork {
    private let network: Network
    // TODO: Add Paging manager
    private var pageNumber: Int = 1
    private var itemsPerPage: Int = 100
    
    init(network: Network) {
        self.network = network
    }
    
    func retrieveProductList(
        searchValue: String? = nil,
        completion: @escaping (Result<Data, NetworkError>) -> Void
    )  {
        let endPoint = EndPoint(
            parameters: .productList(
                pageNumber: pageNumber,
                itemsPerPage: itemsPerPage,
                searchValue: searchValue
            )
        )
        network.request(endPoint: endPoint, completion: completion)
    }
    
    func retrieveProductDetails(
        productIdentifier: Int,
        completion: @escaping (Result<Data, NetworkError>) -> Void
    ) {
        let endPoint = EndPoint(
            parameters: .productDetails(productIdentifier: productIdentifier)
        )
        network.request(endPoint: endPoint, completion: completion)
    }
}
