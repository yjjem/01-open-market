//
//  UIImage + resize.swift
//  01-open-market
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import UIKit

extension UIImage {
    func resize(width: CGFloat, height: CGFloat) -> UIImage? {
        let size = CGSize(width: width, height: height)
        let render = UIGraphicsImageRenderer(size: size)
        return render.image { ctx in
            self.draw(in: .init(origin: .zero, size: size))
        }
    }
}

extension UIImageView {
    
    func setImage(with url: String) {
        let cacheKey = NSString(string: url)
        
        if let cacheImage = CacheManager.imagesCache.object(forKey: cacheKey) {
            self.image = cacheImage
            return
        }
        
        DispatchQueue.global().async {
            if let url = URL(string: url) {
                guard let data = try? Data(contentsOf: url) else {
                    self.image = UIImage(named: "noImage")
                    return
                }
                DispatchQueue.main.async {
                    guard let image = UIImage(data: data) else { return }
                    CacheManager.imagesCache.setObject(image, forKey: cacheKey)
                    self.image = UIImage(data: data)
                }
            }
        }
    }
}
