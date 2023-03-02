//
//  Vendor.swift
//  01-open-market
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import Foundation

struct Vendor: Decodable, Hashable {
    let identifier: Int
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name
    }
}
