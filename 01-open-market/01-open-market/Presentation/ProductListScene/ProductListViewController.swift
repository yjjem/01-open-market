//
//  ProductListViewController.swift
//  01-open-market
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit

final class ProductListViewController: UIViewController {
    private enum Section {
        case productList
    }
    private enum TitleString {
        static let openMarket = "OpenMarket"
    }
    
    private let productsCollectionView: ProductListCollectionView = {
        let collectionView = ProductListCollectionView(
            frame: .zero,
            collectionViewLayout: .init()
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    private var dataSource: UICollectionViewDiffableDataSource<Section, String>?
    
    // Override(s)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationItems()
        configureCollectionView()
    }
    
    // Function(s)
    
    private func configureNavigationItems() {
        navigationItem.titleView = createCollectionViewSwitcher()
        let leftButton = UIBarButtonItem(title: TitleString.openMarket, menu: .none)
        let attributes: [NSAttributedString.Key : Any] = [
            .font: UIFont.boldSystemFont(ofSize: 16)
        ]
        leftButton.setTitleTextAttributes(attributes, for: .normal)
        leftButton.tintColor = .black
        navigationItem.leftBarButtonItem = leftButton
    }
    
    private func configureCollectionView() {
        configureConstraints()
        initializeDataSource()
        updateSnapShot()
    }
    
    private func updateSnapShot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.productList])
        snapshot.appendItems(["Hello","Hello1","Hello2","Hello3","Hello4"])
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    private func configureConstraints() {
        view.addSubview(productsCollectionView)
        NSLayoutConstraint.activate([
            productsCollectionView.topAnchor
                .constraint(
                    equalTo: view.safeAreaLayoutGuide.topAnchor
                ),
            productsCollectionView.leadingAnchor
                .constraint(
                    equalTo: view.safeAreaLayoutGuide.leadingAnchor
                ),
            productsCollectionView.trailingAnchor
                .constraint(
                    equalTo: view.safeAreaLayoutGuide.trailingAnchor
                ),
            productsCollectionView.bottomAnchor
                .constraint(
                    equalTo: view.bottomAnchor
                )
        ])
    }
    
    private func initializeDataSource() {
        let registration = createCellRegistration()
        dataSource = UICollectionViewDiffableDataSource<Section, String>(
            collectionView: productsCollectionView
        ) { collectionView, indexPath, data in
            return collectionView.dequeueConfiguredReusableCell(
                using: registration,
                for: indexPath,
                item: data
            )
        }
        
        productsCollectionView.dataSource = dataSource
    }
    
    private func createCellRegistration()
    -> UICollectionView.CellRegistration<ProductCell, String> {
        let registration = UICollectionView.CellRegistration<ProductCell, String> {
            cell, indexPath, data in
            
            // TODO : Configure cell
            
        }
        return registration
    }
    
    private func createCollectionViewSwitcher() -> UISegmentedControl {
        guard let listImage = UIImage(named: "list")?.resize(width: 15, height: 15),
              let gridImage = UIImage(named: "grid")?.resize(width: 15, height: 15)
        else {
            return UISegmentedControl()
        }
        let items: [UIImage] = [listImage, gridImage]
        let segementControl = UISegmentedControl(items: items)
        segementControl.selectedSegmentIndex = 0
        segementControl.addTarget(self, action: #selector(switchViewStyle), for: .valueChanged)
        return segementControl
    }
    
    @objc
    func switchViewStyle() {
        if productsCollectionView.layoutStyle == .vertical {
            productsCollectionView.layoutStyle = .grid
        } else {
            productsCollectionView.layoutStyle = .vertical
        }
    }
}
