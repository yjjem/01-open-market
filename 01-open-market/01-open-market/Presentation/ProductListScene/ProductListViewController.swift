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
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, ProductResponse>?
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
        productsCollectionView.delegate = self
    }
    
    private func configureCollectionViewRefreshControl() {
        let refreshControl  = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(startRefreshControl), for: .valueChanged)
        productsCollectionView.refreshControl = refreshControl
    }
    
    private func updateSnapShot(with data: [ProductResponse]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ProductResponse>()
        snapshot.appendSections([.productList])
        snapshot.appendItems(data)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    private func initializeDataSource() {
        let registration = createCellRegistration()
        dataSource = UICollectionViewDiffableDataSource<Section, ProductResponse>(
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
    -> UICollectionView.CellRegistration<ProductCell, ProductResponse> {
        let registration = UICollectionView.CellRegistration<ProductCell, ProductResponse> {
            cell, indexPath, data in
            let productCellViewModel = data.asProductCellViewModel()
            cell.viewModel = productCellViewModel
            cell.configureUsingViewModel()
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
        let rightButton = UIBarButtonItem(
            image: .add,
            style: .plain,
            target: self,
            action: #selector(didTapAddProductButton)
        )
        let attributes: [NSAttributedString.Key : Any] = [
            .font: UIFont.boldSystemFont(ofSize: 16)
        ]
        leftButton.setTitleTextAttributes(attributes, for: .normal)
        leftButton.tintColor = .black
        rightButton.tintColor = .black
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem = rightButton
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
    
    private func presentProductEditView(style: ProductDetailsViewModel.Style) {
        let view = ProductDetailsViewController()
        let service = MarketService()
        let useCase = ProductListUseCase(service: service)
        view.viewModel = ProductDetailsViewModel(presentingStyle: style, useCase: useCase)
        navigationController?.pushViewController(view, animated: true)
    }
    
    @objc
    private func didTapAddProductButton() {
        presentProductEditView(style: .post)
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

extension ProductListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? ProductCell
        if let product = cell?.viewModel?.asPostProduct() {
            presentProductEditView(style: .edit(product: product))
        }
    }
}
