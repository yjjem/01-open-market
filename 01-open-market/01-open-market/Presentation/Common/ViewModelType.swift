//
//  ViewModelType.swift
//  01-open-market
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
