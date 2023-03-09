//
//  ImageLoadView.swift
//  Wanted_GCD
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import UIKit

final class ImageLoadView: UIView {
    
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var progressView: UIProgressView!
    @IBOutlet private var loadButton: UIButton!
    
    func reset() {
        imageView.image = .init(systemName: "photo")
        progressView.progress = 0
        loadButton.isEnabled = true
        
    }
    func load() {
        loadButton.sendActions(for: .touchUpInside)
    }
    
    @IBAction private func touchUpLoadButton(_sender: UIButton) {
        
    }
    
}
