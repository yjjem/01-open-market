//
//  NetworkError.swift
//  01-open-market
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

enum NetworkError: Error {
    case wrongURLFormat
    case requestFailed
    case serverProblem
    case transportError
    case missingData
    case decodeError
}
