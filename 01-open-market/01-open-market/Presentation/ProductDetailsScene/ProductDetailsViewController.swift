//
//  ProductDetailsViewController.swift
//  01-open-market
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit
import RxSwift

final class ProductDetailsViewController: UIViewController {
    enum Style {
        case post
        case edit
    }
    
    // MARK: View(s)
    
    private let productImagesView: UIView = {
        let collectionView: UIView = UIView()
        collectionView.backgroundColor = .systemOrange
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let productNameView: NameableTextFieldView = {
        let nameableTextView = NameableTextFieldView(name: "Name")
        return nameableTextView
    }()
    private let priceNameView: NameableTextFieldView = {
        let nameableTextView = NameableTextFieldView(name: "Price")
        return nameableTextView
    }()
    private let discountNameView: NameableTextFieldView = {
        let nameableTextView = NameableTextFieldView(name: "Discount")
        return nameableTextView
    }()
    private let stockNameView: NameableTextFieldView = {
        let nameableTextView = NameableTextFieldView(name: "Stock")
        return nameableTextView
    }()
    
    private let currencySelectorView: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: ["KRW", "USD"])
        segmentControl.selectedSegmentIndex = 0
        segmentControl.isEnabled = false
        return segmentControl
    }()
    
    private let priceStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        return stack
    }()
    private let detailDataStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.layoutMargins = UIEdgeInsets(
            top: 20,
            left: 20,
            bottom: 20,
            right: 20
        )
        stack.spacing = 10
        stack.isLayoutMarginsRelativeArrangement = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private let productDescriptionTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .systemGreen
        textView.font = UIFont(name: "ArialHebrew", size: 20)
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let disposeBag = DisposeBag()
    var viewModel: ProductDetailsViewModel?
    
    
    // MARK: Override(s)
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .systemGray6
        combineViews()
        configureViewConstraints()
        configureNavigationItems()
        configureInitialProductEditability()
        bindViewModel()
    }
    
    // MARK: Private Function(s)
    
    private func configureInitialProductEditability() {
        guard let viewModel = viewModel else { return }
        
        switch viewModel.presentingStyle {
        case .edit(_):
            configureProductEditMode(isEditable: false)
        case .post:
            configureProductEditMode(isEditable: true)
        }
    }
    
    private func bindViewModel() {
        guard let viewModel = viewModel else { return }
        
        let initialSetUpTrigger = self.rx.methodInvoked(#selector(viewDidLoad))
            .map { _ in}
            .asObservable()
        
        let doneTrigger = self.rx.methodInvoked(#selector(didTapDoneButton))
            .map { _ in }
            .asObservable()
        let editTrigger = self.rx.methodInvoked(#selector(didTapEditbutton))
            .map { _ in }
            .asObservable()
        
        
        let output = viewModel.transform(
            input: .init(
                initialSetUpTrigger: initialSetUpTrigger,
                doneTrigger: doneTrigger,
                editTrigger: editTrigger
            )
        )
        
        output.initialSetUpResponse
            .filter { $0 != nil }
            .subscribe(onNext: { [weak self] data in
                self?.setString(data: data)
            })
            .disposed(by: disposeBag)
        
        output.doneResponse
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func setString(data: PostProduct?) {
        guard let data = data else { return }
        productNameView.text = data.name
        priceNameView.text = data.price.description
        discountNameView.text = data.discount.description
        stockNameView.text = data.stock.description
        
        switch data.currency {
        case .KRW:
            currencySelectorView.selectedSegmentIndex = 0
        case .USD:
            currencySelectorView.selectedSegmentIndex = 1
        }
    }
    
    private func configureProductEditMode(isEditable: Bool) {
        productNameView.isEditable = isEditable
        priceNameView.isEditable = isEditable
        discountNameView.isEditable = isEditable
        stockNameView.isEditable = isEditable
        currencySelectorView.isEnabled = isEditable
        productDescriptionTextView.isEditable = isEditable
    }
    
    private func createDoneButton() -> UIBarButtonItem {
        return UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(didTapDoneButton)
        )
    }
    
    @objc
    private func didTapDoneButton() {
        navigationController?.popViewController(animated: true)
    }
    
    
    @objc
    private func didTapEditbutton() {
        configureProductEditMode(isEditable: true)
        navigationItem.rightBarButtonItem = createDoneButton()
    }
    
    private func configureNavigationItems() {
        guard let viewModel = viewModel else { return }
        let editButton = UIBarButtonItem(
            barButtonSystemItem: .edit,
            target: self,
            action: #selector(didTapEditbutton)
        )
        switch viewModel.presentingStyle {
        case .edit(product: let product):
            navigationItem.title = product.name
            navigationItem.rightBarButtonItem = editButton
        case .post:
            let doneButton = createDoneButton()
            doneButton.isEnabled = false
            navigationItem.rightBarButtonItem = doneButton
        }
    }
    
    private func combineViews() {
        let productPriceViews: [UIView] = [
            priceNameView,
            currencySelectorView,
        ]
        let productDetailsViews: [UIView] = [
            productNameView,
            priceStackView,
            discountNameView,
            stockNameView
        ]
        priceStackView.addMultipleArrangedSubviews(productPriceViews)
        detailDataStackView.addMultipleArrangedSubviews(productDetailsViews)
        view.addSubview(productImagesView)
        view.addSubview(detailDataStackView)
        view.addSubview(productDescriptionTextView)
    }
    
    private func configureViewConstraints() {
        
        NSLayoutConstraint.activate([
            productImagesView.topAnchor
                .constraint(
                    equalTo: view.safeAreaLayoutGuide.topAnchor
                ),
            productImagesView.heightAnchor
                .constraint(
                    equalTo: view.heightAnchor,
                    multiplier: 0.2
                ),
            productImagesView.widthAnchor
                .constraint(
                    equalTo: view.widthAnchor
                ),
        ])
        
        NSLayoutConstraint.activate([
            detailDataStackView.topAnchor
                .constraint(
                    equalTo: productImagesView.bottomAnchor
                ),
            detailDataStackView.heightAnchor
                .constraint(
                    equalTo: view.heightAnchor,
                    multiplier: 0.25
                ),
            detailDataStackView.widthAnchor
                .constraint(
                    equalTo: view.widthAnchor
                ),
        ])
        
        NSLayoutConstraint.activate([
            productDescriptionTextView.topAnchor
                .constraint(
                    equalTo: detailDataStackView.bottomAnchor
                ),
            productDescriptionTextView.widthAnchor
                .constraint(
                    equalTo: view.widthAnchor
                ),
            productDescriptionTextView.bottomAnchor
                .constraint(
                    greaterThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor
                ),
        ])
        
        NSLayoutConstraint.activate([
            priceNameView.trailingAnchor
                .constraint(
                    equalTo: currencySelectorView.leadingAnchor,
                    constant: -10
                ),
            currencySelectorView.leadingAnchor
                .constraint(
                    equalTo: priceNameView.trailingAnchor,
                    constant: 20
                ),
            currencySelectorView.topAnchor
                .constraint(
                    equalTo: priceStackView.topAnchor
                ),
            currencySelectorView.trailingAnchor
                .constraint(
                    equalTo: priceStackView.trailingAnchor
                ),
            currencySelectorView.bottomAnchor
                .constraint(
                    equalTo: priceStackView.bottomAnchor
                ),
            currencySelectorView.widthAnchor
                .constraint(
                    equalTo: priceStackView.widthAnchor,
                    multiplier: 0.25
                ),
        ])
    }
}
