//
//  LeagueListUseCaseTests.swift
//  ParisSportifTests
//
//  Created by reda.mimouni.ext on 25/12/2023.
//

import Foundation
import XCTest
import APICaller
@testable import ParisSportif

final class LeagueListUseCaseTests: XCTestCase {

    @MainActor
    func test_fetchLeagueList_shouldSuccess() async {
        // Given
        let repositoryMock = LeagueListRepositoryMock()
        repositoryMock.stubbedFetchResult = [.mock]
        let sut = LeagueListUseCase(repository: repositoryMock)

        // When
        do {
            let result = try await sut.execute()

            // Then
            XCTAssertEqual(result, [.init(idLeague: 4328, strLeague: "English Premier League")], "wrong result shoud be id 4328 strLeague English Premier League")
        } catch {
            XCTFail("Should not throw error")
        }
    }

    @MainActor
    func test_fetchLeagueList_shouldThrowFetchingError() async {
        // Given
        let repositoryMock = LeagueListRepositoryMock()
        let sut = LeagueListUseCase(repository: repositoryMock)

        // When
        do {
            try await sut.execute()

            // Then
            XCTFail("Should throw error")
        } catch {
            XCTAssertEqual(
                error.localizedDescription,
                "Fetching data error",
                "message should be Fetching data error"
            )
        }
    }
}

@MainActor
private final class LeagueListRepositoryMock: LeagueListRepositoryProtocol {

    var stubbedFetchResult: [LeagueDTO]?

    func fetchLeagueList() async throws -> [LeagueDTO] {
        guard let result = stubbedFetchResult else { throw PSError.errorDataFetch }
        return result
    }
}
