//
//  HTTPConetentType.swift
//  01-open-market
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

enum HTTPContentType {
    enum Text {
        static let plain = "text/plain"
    }
    enum Image {
        static let jpeg = "image/jpeg"
        static let png = "image/png"
    }
    enum Multipart {
        static let formData = "multipart/form-data"
    }
}
