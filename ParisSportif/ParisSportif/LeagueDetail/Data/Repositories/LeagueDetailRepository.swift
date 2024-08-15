//
//  LeagueDetailRepository.swift
//  ParisSportif
//
//  Created by reda.mimouni.ext on 27/12/2023.
//

import Foundation
import APICaller

protocol LeagueDetailRepositoryProtocol: Sendable {
    func fetchLeagueDetail(for name: String) async throws -> [TeamDTO]
}

final class LeagueDetailRepository: LeagueDetailRepositoryProtocol {
    private let apiCaller: any APICallerProtocol

    init(apiCaller: some APICallerProtocol = APICaller()) {
        self.apiCaller = apiCaller
    }

    @discardableResult
    func fetchLeagueDetail(for name: String) async throws -> [TeamDTO] {
        do {
            let dto: LeagueDetailDTO = try await self.apiCaller.perform(.searchAllTeams(name: name))
            return dto.teams
        } catch is PSError {
            throw PSError.parsingError
        } catch {
            throw PSError.errorDataFetch
        }
    }
}

extension TeamDTO {
    func toEntity() throws -> TeamEntity {
        guard let teamBadge = URL(string: self.strBadge),
              let id = Int(self.idTeam)
        else { throw PSError.typeConversionError }
        return .init(
            id: id,
            name: self.strTeam,
            badgeImageUrl: teamBadge,
            bannerImageUrl: strBanner.flatMap { URL(string: $0) },
            country: self.strCountry,
            league: self.strLeague,
            descriptionEN: self.strDescriptionEN
        )
    }
}
