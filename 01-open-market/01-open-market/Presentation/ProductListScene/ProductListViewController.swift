//
//  ProductListViewController.swift
//  01-open-market
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit

final class ProductListViewController: UIViewController {
    enum Style: String {
        case vertical = "list"
        case grid = "grid"
    }
    enum Section {
        case productList
    }
    
    private let productsCollectionView: UICollectionView = {
        let collectionView: UICollectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: .init()
        )
        return collectionView
    }()
    
    // TODO: Create Snapshot, DataSource
    
    // Override(s)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationItems()
    }
    
    // Function(s)
    
    func configureNavigationItems() {
        navigationItem.titleView = createCollectionViewSwitcher()
    }
    
    func createCollectionViewSwitcher() -> UISegmentedControl {
        guard let listImage = UIImage(named: "list")?.resize(to: .init(width: 15, height: 15)),
              let gridImage = UIImage(named: "grid")?.resize(to: .init(width: 15, height: 15))
        else {
            return UISegmentedControl()
        }
        let items: [UIImage] = [listImage, gridImage]
        let segementControl = UISegmentedControl(items: items)
        segementControl.selectedSegmentIndex = 0
        return segementControl
    }
}
