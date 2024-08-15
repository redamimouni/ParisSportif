//
//  URLSession+Extensions.swift
//  ParisSportif
//
//  Created by reda.mimouni.ext on 25/12/2023.
//

import Foundation

public protocol URLSessionProtocol: Sendable {
    func data(with request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {
    public func data(with request: URLRequest) async throws -> (Data, URLResponse) {
        return try await data(for: request)
    }
}
