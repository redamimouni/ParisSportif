//
//  LeagueDetailUseCase.swift
//  ParisSportif
//
//  Created by reda.mimouni.ext on 27/12/2023.
//

import Foundation

protocol LeagueDetailUseCaseProtocol: Sendable {
    func execute(league: String) async throws -> [TeamEntity]
}

final class LeagueDetailUseCase: LeagueDetailUseCaseProtocol {
    private let repository: any LeagueDetailRepositoryProtocol

    init(repository: some LeagueDetailRepositoryProtocol = LeagueDetailRepository()) {
        self.repository = repository
    }

    func execute(league: String) async throws -> [TeamEntity] {
        let teams = try await self.repository.fetchLeagueDetail(for: league)
            .map {
                try $0.toEntity()
            }
        return teams.enumerated().compactMap { index, team in
            index.isMultiple(of: 2) ? team : nil
        }.sorted {
            $0 > $1
        }
    }
}
