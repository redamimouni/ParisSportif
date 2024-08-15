//
//  LeagueListRepository.swift
//  ParisSportif
//
//  Created by reda.mimouni.ext on 21/12/2023.
//

import Foundation
import APICaller

protocol LeagueListRepositoryProtocol: Sendable {
    func fetchLeagueList() async throws -> [LeagueDTO]
}

final class LeagueListRepository: LeagueListRepositoryProtocol {
    private let apiCaller: any APICallerProtocol

    init(apiCaller: some APICallerProtocol = APICaller()) {
        self.apiCaller = apiCaller
    }

    @discardableResult
    func fetchLeagueList() async throws -> [LeagueDTO] {
        let dto: LeagueListDTO = try await self.apiCaller.perform(.list)
        return dto.leagues
    }
}

extension LeagueDTO {
    func toEntity() throws -> LeagueEntity {
        guard let idLeagueInt = Int(idLeague) else {
            throw PSError.typeConversionError
        }
        return LeagueEntity(idLeague: Int(idLeagueInt), strLeague: strLeague)
    }
}
