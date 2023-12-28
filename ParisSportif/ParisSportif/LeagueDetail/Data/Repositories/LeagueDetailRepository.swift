//
//  LeagueDetailRepository.swift
//  ParisSportif
//
//  Created by reda.mimouni.ext on 27/12/2023.
//

import Foundation

protocol LeagueDetailRepositoryProtocol {
    func fetchLeagueDetail(for name: String) async throws -> [TeamDTO]
}

final class LeagueDetailRepository: LeagueDetailRepositoryProtocol {
    private let apiCaller: any APICallerProtocol

    init(apiCaller: any APICallerProtocol = APICaller()) {
        self.apiCaller = apiCaller
    }

    func fetchLeagueDetail(for name: String) async throws -> [TeamDTO] {
        guard let request = URLRequest.urlRequestFrom(urlString: APIEndpoints.searchAllTeams(for: name)) else {
            throw PSError.wrongUrlError
        }
        do {
            let dto: LeagueDetailDTO = try await self.apiCaller.perform(request)
            return dto.teams
        } catch is PSError {
            throw PSError.parsingError
        } catch {
            throw PSError.errorDataFetch
        }
    }
}
