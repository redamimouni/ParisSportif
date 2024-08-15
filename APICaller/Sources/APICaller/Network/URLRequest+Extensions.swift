//
//  URLRequest+Extensions.swift
//  ParisSportif
//
//  Created by reda.mimouni.ext on 21/12/2023.
//

import Foundation

extension URLRequest {
    public static var list: URLRequest? {
        guard let request = URLRequest.buildRequest(from: APIEndpoints.listing) else {
            return nil
        }
        return request
    }

    public static func searchAllTeams(name: String) -> URLRequest? {
        guard let request = URLRequest.buildRequest(from: APIEndpoints.searchAllTeams(for: name)) else {
            return nil
        }
        return request
    }

    private static func buildRequest(from urlString: String) -> URLRequest? {
        guard let url = URL(string: urlString) else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
}
