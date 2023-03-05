//
//  ProductListUseCase.swift
//  01-open-market
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import Foundation
import RxSwift

protocol ProductListUseCaseType {
    func retrieveProductList() -> Observable<[Product]>
    func reloadProductList() -> Observable<[Product]>
}

final class ProductListUseCase: ProductListUseCaseType {
    
    let service: MarketServiceType
    
    init(service: MarketServiceType) {
        self.service = service
    }
    
    func retrieveProductList() -> Observable<[Product]> {
        return service.retrieveProductsData(reload: false)
            .flatMap { list in
                Observable.just(list)
            }
    }

    func reloadProductList() -> Observable<[Product]> {
        return service.retrieveProductsData(reload: true)
            .flatMap { list in
                Observable.just(list)
            }
    }
}
