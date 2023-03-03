//
//  UIStackView + addMultipleArrangedSubviews.swift
//  01-open-market
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import UIKit

extension UIStackView {
    func addMultipleArrangedSubviews(_ views: [UIView]) {
        views.forEach { self.addArrangedSubview($0) }
    }
}
