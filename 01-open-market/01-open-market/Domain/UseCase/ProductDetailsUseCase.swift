//
//  ProductDetailsUseCase.swift
//  01-open-market
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import Foundation
import RxSwift

protocol ProductDetailsUseCaseType {
    func retrieveProductDetails(identifier: Int) -> Observable<RepresentableProductDetails>
}

final class ProductDetailsUseCase: ProductDetailsUseCaseType {
    
    let service: MarketServiceType
    
    init(service: MarketServiceType) {
        self.service = service
    }
    
    func retrieveProductDetails(identifier: Int) -> Observable<RepresentableProductDetails> {
        return service.retrieveProductDetails(identifier: identifier)
            .map {
                let images = $0.images
                    .map { URL(string: $0.url) }
                    .compactMap { $0?.createImage() }
                
                return RepresentableProductDetails(
                    name: $0.name,
                    price: $0.price,
                    currency: $0.currency,
                    discount: $0.discountedPrice,
                    description: $0.description,
                    stock: $0.stock,
                    images: images
                )
            }
    }
}
import UIKit

extension URL {
    func createImage() -> UIImage {
        let cacheKey = NSString(string: self.absoluteString)
        
        if let cacheImage = CacheManager.thumbnailCache.object(forKey: cacheKey) {
            return cacheImage
        }
        if let data = try? Data(contentsOf: self),
           let image = UIImage(data: data) {
            CacheManager.thumbnailCache.setObject(image, forKey: cacheKey)
            return image
        }
        return UIImage()
    }
}
