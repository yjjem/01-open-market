//
//  MarketRepositoryType.swift
//  01-open-market
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import Foundation
import RxSwift

protocol MarketServiceType {
    func retrieveProductsData(reload: Bool) -> Observable<[ProductResponse]>
    func retrieveProductDetails(identifier: Int) -> Observable<ProductDetailsResponse>
}
