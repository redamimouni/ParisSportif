//
//  URLSession+Extensions.swift
//  ParisSportif
//
//  Created by reda.mimouni.ext on 25/12/2023.
//

import Foundation

protocol URLSessionProtocol {
    func data(with request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {
    func data(with request: URLRequest) async throws -> (Data, URLResponse) {
        return try await data(for: request)
    }
}
