//
//  ViewController.swift
//  Wanted_GCD
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet private var views: [ImageLoadView]!

    override func loadView() {
        super.loadView()
        
        views.forEach { $0.reset() }
    }
}

