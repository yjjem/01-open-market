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
