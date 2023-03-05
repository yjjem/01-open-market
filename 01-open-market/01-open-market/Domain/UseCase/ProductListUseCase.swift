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
    
    let repository: ProductListRepositoryType
    
    init(repository: ProductListRepositoryType) {
        self.repository = repository
    }
    
    func retrieveProductList() -> Observable<[Product]> {
        return repository.retrieveProductList(reload: false)
            .flatMap { list in
                Observable.just(list.pages)
            }
    }
    
    func reloadProductList() -> Observable<[Product]> {
        return repository.retrieveProductList(reload: true)
            .flatMap { list in
                Observable.just(list.pages)
            }
    }
}
