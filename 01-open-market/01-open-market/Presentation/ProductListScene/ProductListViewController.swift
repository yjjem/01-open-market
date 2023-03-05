//
//  ProductListViewController.swift
//  01-open-market
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit
import RxSwift
import RxCocoa

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
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Product>?
    private let disposeBag: DisposeBag = DisposeBag()
    
    var viewModel: ProductListViewModel?
    
    // Override(s)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationItems()
        configureCollectionView()
        bindViewModel()
    }
    
    // Private Function(s)
    
    private func bindViewModel() {
        guard let viewModel = viewModel else { return }
        
        let reloadButtonTrigger = rx.methodInvoked(#selector(logoDidTapped)).asObservable()
        let refreshControlTrigger = rx.methodInvoked(#selector(startRefreshControl)).asObservable()
        let viewWillAppearTrigger = rx.methodInvoked(#selector(viewWillAppear)).asObservable()
        
        let reloadTrigger = Observable.of(
            reloadButtonTrigger,
            viewWillAppearTrigger,
            refreshControlTrigger
        )
            .merge()
            .map { _ in }
            .asObservable()
        
        let output = viewModel.transform(
            input: .init(
                reloadTrigger: reloadTrigger
            )
        )
        
        output.reloadResponse
            .subscribe(onNext: { [weak self] data in
                self?.updateSnapShot(with: data)
                DispatchQueue.main.async {
                    if let refresh = self?.productsCollectionView.refreshControl,
                        refresh.isRefreshing {
                        refresh.endRefreshing()
                    }
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func configureCollectionView() {
        combineViews()
        configureConstraints()
        initializeDataSource()
        configureCollectionViewRefreshControl()
    }
    
    private func configureCollectionViewRefreshControl() {
        let refreshControl  = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(startRefreshControl), for: .valueChanged)
        productsCollectionView.refreshControl = refreshControl
    }
    
    private func updateSnapShot(with data: [Product]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Product>()
        snapshot.appendSections([.productList])
        snapshot.appendItems(data)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    private func initializeDataSource() {
        let registration = createCellRegistration()
        dataSource = UICollectionViewDiffableDataSource<Section, Product>(
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
    -> UICollectionView.CellRegistration<ProductCell, Product> {
        let registration = UICollectionView.CellRegistration<ProductCell, Product> {
            cell, indexPath, data in
            cell.setUpWith(product: data)
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
    
    private func configureNavigationItems() {
        navigationItem.titleView = createCollectionViewSwitcher()
        let leftButton = UIBarButtonItem(
            title: TitleString.openMarket,
            style: .plain,
            target: self,
            action: #selector(logoDidTapped)
        )
        let attributes: [NSAttributedString.Key : Any] = [
            .font: UIFont.boldSystemFont(ofSize: 16)
        ]
        leftButton.setTitleTextAttributes(attributes, for: .normal)
        leftButton.tintColor = .black
        leftButton.action = #selector(logoDidTapped)
        navigationItem.leftBarButtonItem = leftButton
    }
    
    private func combineViews() {
        view.addSubview(productsCollectionView)
    }
    
    private func configureConstraints() {
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
    
    @objc
    private func startRefreshControl() { }
    
    @objc
    private func logoDidTapped() {
        productsCollectionView.setContentOffset(.zero, animated: true)
    }
    
    @objc
    private func switchViewStyle() {
        if productsCollectionView.layoutStyle == .vertical {
            productsCollectionView.layoutStyle = .grid
        } else {
            productsCollectionView.layoutStyle = .vertical
        }
    }
}
