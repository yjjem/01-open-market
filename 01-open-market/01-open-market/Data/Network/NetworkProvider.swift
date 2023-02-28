//
//  NetworkProvider.swift
//  01-open-market
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import Foundation

final class NetworkProvider {
    enum Hosts {
        static let market = "https://openmarket.yagom-academy.kr"
    }
    
    func createPostNetwork() -> PostNetwork {
        let network = Network<Post>(host: Hosts.market)
        return PostNetwork(network: network)
    }
}
