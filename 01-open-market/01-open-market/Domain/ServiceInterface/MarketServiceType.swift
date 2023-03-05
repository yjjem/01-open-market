//
//  MarketRepositoryType.swift
//  01-open-market
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import Foundation
import RxSwift

protocol MarketServiceType {
    func retrieveProductList(reload: Bool) -> Observable<ProductList>
}
