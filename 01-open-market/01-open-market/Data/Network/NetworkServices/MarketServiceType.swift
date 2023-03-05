//
//  MarketRepositoryType.swift
//  01-open-market
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import Foundation
import RxSwift

protocol MarketServiceType {
    func retrieveProductList(
        parameters: ProductListRequest,
        completion: @escaping (Result<ProductList, NetworkError>) -> Void
    ) -> URLSessionDataTask?
}
