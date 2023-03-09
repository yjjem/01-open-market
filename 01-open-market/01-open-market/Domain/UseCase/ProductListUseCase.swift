//
//  ProductListUseCase.swift
//  01-open-market
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import Foundation
import RxSwift

protocol ProductListUseCaseType {
    func retrieveProductList() -> Observable<[ProductResponse]>
    func reloadProductList() -> Observable<[ProductResponse]>
}

final class ProductListUseCase: ProductListUseCaseType {
    
    let service: MarketServiceType
    
    init(service: MarketServiceType) {
        self.service = service
    }
    
    func retrieveProductList() -> Observable<[ProductResponse]> {
        return service.retrieveProductsData(reload: false)
    }

    func reloadProductList() -> Observable<[ProductResponse]> {
        return service.retrieveProductsData(reload: true)
    }
}
