//
//  LeagueDetailRepository.swift
//  ParisSportif
//
//  Created by reda.mimouni.ext on 27/12/2023.
//

import Foundation

protocol LeagueDetailRepositoryProtocol {
    func fetchLeagueDetail(for name: String) async throws -> LeagueDetailDTO
}

final class LeagueDetailRepository: LeagueDetailRepositoryProtocol {
    private let urlSession: any URLSessionProtocol

    init(urlSession: any URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }

    func fetchLeagueDetail(for name: String) async throws -> LeagueDetailDTO {
        guard let request = URLRequest.urlRequestFrom(urlString: APIEndpoints.searchAllTeams(for: name)) else {
            throw PSError.wrongUrlError
        }
        do {
            let (data, _) = try await self.urlSession.data(with: request)
            return try self.decodeEntityFromData(data: data)
        } catch is PSError {
            throw PSError.parsingError
        } catch {
            throw PSError.errorDataFetch
        }
    }

    private func decodeEntityFromData(data: Data) throws -> LeagueDetailDTO {
        do {
            return try JSONDecoder().decode(LeagueDetailDTO.self, from: data)
        } catch {
            throw PSError.parsingError
        }
    }
}
