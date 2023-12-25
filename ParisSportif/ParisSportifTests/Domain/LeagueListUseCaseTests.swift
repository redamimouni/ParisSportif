//
//  LeagueListUseCaseTests.swift
//  ParisSportifTests
//
//  Created by reda.mimouni.ext on 25/12/2023.
//

import Foundation
import XCTest
@testable import ParisSportif

class LeagueListUseCaseTests: XCTestCase {
    
    func test_fetchLeagueList_shouldSuccess() async {
        // Given
        let repositoryMock = LeagueListRepositoryMock()
        repositoryMock.stubbedFetchResult = .mock()
        let sut = LeagueListUseCase(repository: repositoryMock)

        // When
        do {
            let result = try await sut.fetchLeagueList()

            // Then
            XCTAssertEqual(result, [.init(idLeague: 4328, strLeague: "English Premier League")], "wrong result shoud be id 4328 strLeague English Premier League")
        } catch {
            XCTFail("Should not throw error")
        }
    }

    func test_fetchLeagueList_shouldThrowFetchingError() async {
        // Given
        let repositoryMock = LeagueListRepositoryMock()
        let sut = LeagueListUseCase(repository: repositoryMock)

        // When
        do {
            let _ = try await sut.fetchLeagueList()

            // Then
            XCTFail("Should throw error")
        } catch {
            XCTAssertEqual(error.localizedDescription, "Fetching data error", "message should be Fetching data error")
        }
    }

    func test_fetchLeagueList_shouldThrowTypeConversionError() async {
        // Given
        let repositoryMock = LeagueListRepositoryMock()
        repositoryMock.stubbedFetchResult = .mock(idLeague: "notANumber")
        let sut = LeagueListUseCase(repository: repositoryMock)

        // When
        do {
            let _ = try await sut.fetchLeagueList()

            // Then
            XCTFail("Should throw error")
        } catch {
            XCTAssertEqual(error.localizedDescription, "Type conversion error", "message should be Fetching data error")
        }
    }
}

private class LeagueListRepositoryMock: LeagueListRepositoryProtocol {
    var stubbedFetchResult: LeagueListDTO?

    func fetchLeagueList() async throws -> LeagueListDTO {
        guard let result = stubbedFetchResult else { throw PSError.errorDataFetch }
        return result
    }
}

extension LeagueListDTO {
    static func mock(idLeague: String = "4328") -> LeagueListDTO {
        return LeagueListDTO(leagues: [.init(idLeague: idLeague,
                                             strLeague: "English Premier League",
                                             strSport: "Soccer",
                                             strLeagueAlternate: "Premier League, EPL")])
    }
}
