//
//  ProductListRepositoryType.swift
//  01-open-market
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import RxSwift

protocol ProductListRepositoryType {
    func retrieveProductList(reload: Bool) -> Observable<ProductList>
}
