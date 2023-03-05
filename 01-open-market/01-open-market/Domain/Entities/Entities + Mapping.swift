//
//  Entities + Mapping.swift
//  01-open-market
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import Foundation

extension ProductList {
    func asProducts() -> [Product] {
        return self.pages
    }
}
