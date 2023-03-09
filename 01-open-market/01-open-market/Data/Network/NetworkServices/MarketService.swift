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
    
    func retrieveProductsData(reload: Bool = false) -> Observable<[ProductResponse]> {
        if reload {
            pagingManager.resetPage()
        }
        let parameters = ProductListRequest(pageNumber: pagingManager.pageNumber)
        return Observable.create { [weak self] emitter in
            let task = self?.network.request(parameters: parameters) { response in
                switch response {
                case .success(let data):
                    emitter.onNext(data.asProducts())
                    self?.pagingManager.addPage()
                case .failure(let error):
                    emitter.onError(error)
                }
            }
            return Disposables.create {
                task?.cancel()
            }
        }
    }
    
    func retrieveProductDetails(identifier: Int) -> Observable<ProductDetailsResponse> {
        let parameters = ProductDetailsRequest(productIdentifier: identifier)
        return Observable.create { [weak self] emitter in
            let task = self?.network.request(parameters: parameters, completion: { response in
                switch response {
                case .success(let data):
                    emitter.onNext(data)
                case .failure(let error):
                    emitter.onError(error)
                }
            })
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

