//
//  Post.swift
//  01-open-market
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import Foundation

// TODO: 수정
struct Post: Decodable {
    let name: String
    
    enum CodingKeys: CodingKey {
        case name
    }
}
