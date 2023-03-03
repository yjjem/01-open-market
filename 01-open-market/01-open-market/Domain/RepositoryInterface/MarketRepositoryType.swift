//
//  MarketRepositoryType.swift
//  01-open-market
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import Foundation
import RxSwift

protocol MarketRepositoryType {
    func retrieveItems(searchValue: String?) -> Observable<Data>
    func retrieveItem(productIdentifier: Int) -> Observable<Data>
    // TODO: 삭제, 업로드 기능 추가
}
