//
//  ProductDetailsViewModel.swift
//  01-open-market
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import RxSwift
import UIKit

final class ProductDetailsViewModel: ViewModelType {
    enum Style {
        case edit(product: PostProduct)
        case post
    }
    
    private let useCase: ProductListUseCaseType?
    private var productToEdit: PostProduct?
    var images: [UIImage] = []
    var presentingStyle: Style = .post
    
    init(presentingStyle: Style = .post, useCase: ProductListUseCaseType) {
        self.useCase = useCase
        self.presentingStyle = presentingStyle
        initializeProduct()
    }
    
    // MARK: Function(s)
    
    func transform(input: Input) -> Output {
        
        let initial = input.initialSetUpTrigger
            .flatMap {
                Observable.just(self.productToEdit)
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
        case .edit(let product):
            productToEdit = product
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
        let initialSetUpResponse: Observable<PostProduct?>
        let doneResponse: Observable<Void>
        let editResponse: Observable<Void>
    }
}
