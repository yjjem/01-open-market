//
//  ProductDetailsViewModel.swift
//  01-open-market
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import RxSwift
import UIKit

final class ProductDetailsViewModel: ViewModelType {
    enum Style {
        case edit(productIdentifier: Int)
        case post
    }
    
    private let useCase: ProductDetailsUseCaseType
    private var productIdentifier: Int = 0
    var images: [UIImage] = []
    var presentingStyle: Style = .post
    
    init(presentingStyle: Style = .post, useCase: ProductDetailsUseCaseType) {
        self.useCase = useCase
        self.presentingStyle = presentingStyle
        initializeProduct()
    }
    
    // MARK: Function(s)
    
    func transform(input: Input) -> Output {
        
        let initial = input.initialSetUpTrigger
            .flatMap {
                return self.useCase
                    .retrieveProductDetails(identifier: self.productIdentifier)
            }
        
        let done = input.doneTrigger.asObservable()
        
        let edit = input.editTrigger.asObservable()
        
        return Output(
            initialSetUpResponse: initial,
            doneResponse: done,
            editResponse: edit
        )
    }
    
    private func initializeProduct() {
        switch presentingStyle {
        case .edit(let identifier):
            productIdentifier = identifier
        case .post: return
        }
    }
}

extension ProductDetailsViewModel {
    struct Input {
        let initialSetUpTrigger: Observable<Void>
        let doneTrigger: Observable<Void>
        let editTrigger: Observable<Void>
    }
    struct Output {
        let initialSetUpResponse: Observable<RepresentableProductDetails>
        let doneResponse: Observable<Void>
        let editResponse: Observable<Void>
    }
}
