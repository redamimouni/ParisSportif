//
//  APICaller.swift
//  ParisSportif
//
//  Created by reda.mimouni.ext on 28/12/2023.
//

import Foundation

public protocol APICallerProtocol: Sendable {
    func perform<T: Decodable>(_ request: URLRequest?) async throws -> T
}

public final class APICaller: APICallerProtocol {
    private let urlSession: URLSessionProtocol

    public init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }

    @discardableResult
    public func perform<T: Decodable>(_ request: URLRequest?) async throws -> T {
        guard let request else { throw PSError.wrongUrlError }
        let (data, response) = try await self.urlSession.data(with: request)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw PSError.httpRequestError
        }
        let decoded: T = try self.decodeEntityFromData(data: data)
        return decoded
    }

    private func decodeEntityFromData<T: Decodable>(data: Data) throws -> T {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw PSError.parsingError
        }
    }
}
