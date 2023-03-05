//
//  MarketService.swift
//  01-open-market
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import Foundation
import RxSwift

final class MarketService: MarketServiceType {
    private var pagingManager: PagingManager = .init()
    private let network: NetworkProvider
    
    init(network: NetworkProvider = .init()) {
        self.network = network
    }
    
    func retrieveProductList(reload: Bool = false) -> Observable<ProductList> {
        if reload {
            pagingManager.resetPage()
        }
        let parameters = ProductListRequest(pageNumber: pagingManager.pageNumber)
        return Observable.create { [weak self] emitter in
            let task = self?.network.request(parameters: parameters) { response in
                switch response {
                case .success(let data):
                    emitter.onNext(data)
                case .failure(let error):
                    emitter.onError(error)
                }
            }
            return Disposables.create {
                task?.cancel()
            }
        }
    }
}

fileprivate struct PagingManager {
    var pageNumber: Int = 1
    var pageItemsLimit: Int = 20
    
    mutating func addPage() {
        pageNumber += 1
    }
    
    mutating func resetPage() {
        pageNumber = 1
    }
}

