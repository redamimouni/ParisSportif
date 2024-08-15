//
//  LeagueListUseCase.swift
//  ParisSportif
//
//  Created by reda.mimouni.ext on 21/12/2023.
//

import Foundation

protocol LeagueListUseCaseProtocol: Sendable {
    func execute() async throws -> [LeagueEntity]
}

final class LeagueListUseCase: LeagueListUseCaseProtocol {
    private let repository: any LeagueListRepositoryProtocol

    init(repository: some LeagueListRepositoryProtocol = LeagueListRepository()) {
        self.repository = repository
    }

    @discardableResult
    func execute() async throws -> [LeagueEntity] {
        try await self.repository.fetchLeagueList().map {
            try $0.toEntity()
        }
    }
}
