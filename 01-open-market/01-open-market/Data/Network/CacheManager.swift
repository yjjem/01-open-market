//
//  CacheManager.swift
//  01-open-market
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import Foundation
import UIKit

final class CacheManager {
    static let imagesCache = NSCache<NSString, UIImage>()
    
    private init() { }
}
