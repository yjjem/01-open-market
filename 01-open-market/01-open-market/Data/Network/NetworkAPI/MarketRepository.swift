//
//  MarketRepository.swift
//  01-open-market
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import Foundation
import RxSwift

final class MarketRepository: MarketRepositoryType {
    private let network: NetworkManager
    // TODO: Add Paging manager
    private var pageNumber: Int = 1
    private var itemsPerPage: Int = 100
    
    init(network: NetworkManager) {
        self.network = network
    }
    
    func retrieveItems(searchValue: String? = nil) -> Observable<Data> {
        let endPoint = EndPoint(
            parameters: .productList(
                pageNumber: pageNumber,
                itemsPerPage: itemsPerPage,
                searchValue: searchValue
            )
        )
        return network.request(endPoint: endPoint)
    }
    
    func retrieveItem(productIdentifier: Int) -> Observable<Data> {
        let endPoint: EndPoint = EndPoint(
            parameters: .productDetails(productIdentifier: productIdentifier)
        )
        return network.request(endPoint: endPoint)
    }
}
