//
//  APICaller.swift
//  ParisSportif
//
//  Created by reda.mimouni.ext on 28/12/2023.
//

import Foundation

protocol APICallerProtocol: Sendable {
    func perform<T: Decodable>(_ request: URLRequest) async throws -> T
}

final class APICaller: APICallerProtocol {
    private let urlSession: URLSessionProtocol

    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }

    func perform<T: Decodable>(_ request: URLRequest) async throws -> T {
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
