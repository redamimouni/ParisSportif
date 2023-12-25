//
//  LeagueListRepository.swift
//  ParisSportif
//
//  Created by reda.mimouni.ext on 21/12/2023.
//

import Foundation

protocol LeagueListRepositoryProtocol {
    func fetchLeagueList() async throws -> LeagueListDTO
}

final class LeagueListRepository: LeagueListRepositoryProtocol {
    func fetchLeagueList() async throws -> LeagueListDTO {
        guard let request = URLRequest.urlRequestFrom(urlString: APIEndpoints.listing) else {
            throw PSError.wrongUrlError
        }
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return try self.decodeEntityFromData(data: data)
        } catch is PSError {
            throw PSError.parsingError
        } catch {
            throw PSError.errorDataFetch
        }
    }

    private func decodeEntityFromData(data: Data) throws -> LeagueListDTO {
        do {
            return try JSONDecoder().decode(LeagueListDTO.self, from: data)
        } catch {
            throw PSError.parsingError
        }
    }
}
