//
//  LeagueListRepository.swift
//  ParisSportif
//
//  Created by reda.mimouni.ext on 21/12/2023.
//

import Foundation

protocol LeagueListRepositoryProtocol {
    func fetchLeagueList() async throws -> [LeagueDTO]
}

final class LeagueListRepository: LeagueListRepositoryProtocol {
    private let apiCaller: any APICallerProtocol

    init(apiCaller: some APICallerProtocol = APICaller()) {
        self.apiCaller = apiCaller
    }

    func fetchLeagueList() async throws -> [LeagueDTO] {
        guard let request = URLRequest.buildRequest(from: APIEndpoints.listing) else {
            throw PSError.wrongUrlError
        }
        let dto: LeagueListDTO = try await self.apiCaller.perform(request)
        return dto.leagues
    }
}
