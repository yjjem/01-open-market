//
//  ProductListCollectionView.swift
//  01-open-market
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import UIKit

final class ProductListCollectionView: UICollectionView {
    enum Style: String {
        case vertical = "list"
        case grid = "grid"
    }
    
    var layoutStyle: Style = .vertical {
        didSet {
            updateLayout(type: layoutStyle)
        }
    }
    
    // MARK: - Override(s)
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        updateLayout(type: .vertical)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function(s)
    
    private func updateLayout(type: Style) {
        collectionViewLayout.invalidateLayout()
        switch type {
        case .vertical:
            setCollectionViewLayout(listLayout, animated: true)
        case .grid:
            setCollectionViewLayout(gridLayout, animated: true)
        }
    }
}

extension ProductListCollectionView {
    
    var cellSectionInset: NSDirectionalEdgeInsets {
        return .init(
            top: 10,
            leading: 10,
            bottom: 10,
            trailing: 10
        )
    }
    
    var cellItemsInset: NSDirectionalEdgeInsets {
        return .init(
            top: 5,
            leading: 5,
            bottom: 5,
            trailing: 5
        )
    }
    
    private var listLayout: UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.9)
        )
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(0.2)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = cellSectionInset
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    private var gridLayout: UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalWidth(0.5)
        )
        item.contentInsets = cellItemsInset
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = cellSectionInset
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
}
