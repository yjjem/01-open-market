//
//  PostNetwork.swift
//  01-open-market
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import Foundation

final class PostNetwork {
    private let network: Network<Post>
    
    init(network: Network<Post>) {
        self.network = network
    }
    
    func getProductList(handler: @escaping (Result<Post, Error>) -> Void)  {
        // TODO: 메서드 구현
    }
    
    func getProductDetails(handler: @escaping (Result<Post, Error>) -> Void) {
        // TODO: 메서드 구현, Response 타입 추가 및 수정
    }
}
