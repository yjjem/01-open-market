//
//  ProductsUseCase.swift
//  01-open-market
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import Foundation
import RxSwift

protocol ProductsUseCaseType {
    func retrieveProductList(searchValue: String?) -> Observable<Data>
    func retrieveProduct(productIdentifier: Int) -> Observable<Data>
}

final class ProductUseCase: ProductsUseCaseType {
    
    let repository: MarketRepositoryType
    
    init(repository: MarketRepositoryType) {
        self.repository = repository
    }
    
    func retrieveProductList(searchValue: String? = nil) -> Observable<Data> {
        return repository.retrieveItems(searchValue: searchValue)
    }
    
    func retrieveProduct(productIdentifier: Int) -> Observable<Data> {
        return repository.retrieveItem(productIdentifier: productIdentifier)
    }
}
