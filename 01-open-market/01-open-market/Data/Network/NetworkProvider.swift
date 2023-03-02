//
//  NetworkProvider.swift
//  01-open-market
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import Foundation

final class NetworkProvider {
    private let network: Network
    
    init() {
        self.network = Network()
    }
    
    func createPostNetwork() -> PostNetwork {
        return PostNetwork(network: network)
    }
}
