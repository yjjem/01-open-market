//
//  ProductListViewModel.swift
//  01-open-market
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import Foundation
import RxSwift

final class ProductListViewModel: ViewModelType {
    
    let useCase: ProductListUseCaseType
    
    init(useCase: ProductListUseCaseType) {
        self.useCase = useCase
    }
    
    func transform(input: Input) -> Output {
        let reload = input.reloadTrigger
            .flatMap {
                return self.useCase.reloadProductList()
            }
        return Output(
            reloadResponse: reload
        )
    }
}

extension ProductListViewModel {
    struct Input {
        let reloadTrigger: Observable<Void>
    }
    struct Output {
        let reloadResponse: Observable<[Product]>
    }
}
