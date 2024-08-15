//
//  LeagueDetailViewModelTests.swift
//  ParisSportifTests
//
//  Created by reda.mimouni.ext on 27/12/2023.
//

import Foundation
import XCTest
@testable import ParisSportif

final class LeagueDetailViewModelTests: XCTestCase {

    @MainActor 
    func test_isLoading_shouldReturnTrue() {
        // Given
        let sut = LeagueDetailViewModel(league: .mock())

        // When
        let isLoading = sut.isLoading

        // Then
        XCTAssertTrue(isLoading, "wrong isLoading should be true")
    }

    @MainActor 
    func test_fetchTeams_shouldReturnTeams() async {
        // Given
        let useCaseMock = LeagueDetailUseCaseMock()
        useCaseMock.stubbedFetchResult = [.psg]
        let sut = LeagueDetailViewModel(league: .mock(), useCase: useCaseMock)

        // When
        await sut.fetchTeams()

        // Then
        XCTAssertEqual(sut.teams, [.psg], "wrong teams should equal to psg")
        XCTAssertFalse(sut.isLoading, "wrong isLoading should be false")
    }

    @MainActor 
    func test_fetchTeams_shouldSetError() async {
        // Given
        let useCaseMock = LeagueDetailUseCaseMock()
        let sut = LeagueDetailViewModel(league: .mock(), useCase: useCaseMock)

        // When
        await sut.fetchTeams()

        // Then
        XCTAssertEqual(useCaseMock.invokedFetchCount, 1, "wrong useCase should called once")
        XCTAssertEqual(sut.error?.localizedDescription, "Fetching data error", "wrong error should be Fetching data error")
        XCTAssertFalse(sut.isLoading, "wrong isLoading should be false")
    }
}

@MainActor
private final class LeagueDetailUseCaseMock: LeagueDetailUseCaseProtocol {
    var invokedFetchCount = 0
    var stubbedFetchResult: [TeamEntity]?

    func execute(league: String) async throws -> [TeamEntity] {
        invokedFetchCount += 1
        guard let result = self.stubbedFetchResult else {
            throw PSError.errorDataFetch
        }
        return result
    }
}
