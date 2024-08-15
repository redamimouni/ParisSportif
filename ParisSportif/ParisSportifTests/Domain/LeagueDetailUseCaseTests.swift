//
//  LeagueDetailUseCaseTests.swift
//  ParisSportifTests
//
//  Created by reda.mimouni.ext on 28/12/2023.
//

import Foundation
import XCTest
@testable import ParisSportif

final class LeagueDetailUseCaseTests: XCTestCase {
    func test_execute_givenOneTeam_shoudReturnOneEntity() async {
        // Given
        let repositoryMock = LeagueDetailRepositoryMock()
        repositoryMock.stubbedFetchResult = [.psg]
        let sut = LeagueDetailUseCase(repository: repositoryMock)

        // When
        do {
            let result = try await sut.execute(league: "Ligue 1")

            // Then
            XCTAssertEqual(result, [.psg])
        } catch {
            XCTFail("Should not throw error")
        }
    }

    func test_execute_givenThreeTeams_shoudReturnTwoEntities() async {
        // Given
        let repositoryMock = LeagueDetailRepositoryMock()
        repositoryMock.stubbedFetchResult = [
            .psg,
            .marseille,
            .arsenal,
            .monaco
        ]
        let sut = LeagueDetailUseCase(repository: repositoryMock)

        // When
        do {
            let result = try await sut.execute(league: "Ligue 1")

            // Then
            XCTAssertEqual(
                result,
                [.psg, .arsenal],
                "wrong should return PSG then OM"
            )
        } catch {
            XCTFail("Should not throw error")
        }
    }

    func test_execute_givenTenTeams_shoudReturnFiveEntitiesSortByAntiAlphabetic() async {
        // Given
        let repositoryMock = LeagueDetailRepositoryMock()
        repositoryMock.stubbedFetchResult = [
            .mock(strTeam: "A"),
            .mock(strTeam: "B"),
            .mock(strTeam: "C"),
            .mock(strTeam: "D"),
            .mock(strTeam: "E"),
            .mock(strTeam: "F"),
            .mock(strTeam: "G"),
            .mock(strTeam: "H"),
            .mock(strTeam: "I"),
            .mock(strTeam: "J")
        ]
        let sut = LeagueDetailUseCase(repository: repositoryMock)

        // When
        do {
            let result = try await sut.execute(league: "Ligue 1")

            // Then
            XCTAssertEqual(
                result,
                [
                    .mock(name: "I"),
                    .mock(name: "G"),
                    .mock(name: "E"),
                    .mock(name: "C"),
                    .mock(name: "A")
                ],
                "wrong should return PSG then OM"
            )
        } catch {
            XCTFail("Should not throw error")
        }
    }

    func test_execute_shoudThrowFetchingError() async {
        // Given
        let repositoryMock = LeagueDetailRepositoryMock()
        let sut = LeagueDetailUseCase(repository: repositoryMock)

        // When
        do {
            let _ = try await sut.execute(league: "Ligue 1")

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

private final class LeagueDetailRepositoryMock: LeagueDetailRepositoryProtocol {
    var stubbedFetchResult: [TeamDTO]?

    func fetchLeagueDetail(for name: String) async throws -> [TeamDTO] {
        guard let result = stubbedFetchResult else { throw PSError.errorDataFetch }
        return result
    }
}

extension LeagueDetailDTO {
    static func mock(teams: [TeamDTO] = [.mock()]) -> LeagueDetailDTO {
        return .init(teams: teams)
    }
}
