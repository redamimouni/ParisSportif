//
//  LeagueDetailViewModelTests.swift
//  ParisSportifTests
//
//  Created by reda.mimouni.ext on 27/12/2023.
//

import Foundation
import XCTest
import Combine
@testable import ParisSportif

final class LeagueDetailViewModelTests: XCTestCase {
    private var cancellable = Set<AnyCancellable>()

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
        let taskExpectation = XCTestExpectation()
        let useCaseMock = LeagueDetailUseCaseMock()
        useCaseMock.stubbedFetchResult = [.psg]
        useCaseMock.$invokedFetch
            .filter { $0 }
            .sink { _ in
                Task {
                    taskExpectation.fulfill()
                }
            }.store(in: &self.cancellable)
        let sut = LeagueDetailViewModel(league: .mock(), useCase: useCaseMock)

        // When
        await sut.fetchTeams()

        // Then
        wait(for: [taskExpectation])
        XCTAssertEqual(sut.teams, [.psg], "wrong teams should equal to psg")
        XCTAssertFalse(sut.isLoading, "wrong isLoading should be false")
    }

    @MainActor 
    func test_fetchTeams_shouldSetError() async {
        // Given
        let taskExpectation = XCTestExpectation()
        let useCaseMock = LeagueDetailUseCaseMock()
        useCaseMock.$invokedFetch
            .filter { $0 }
            .sink { _ in
                Task {
                    taskExpectation.fulfill()
                }
            }.store(in: &self.cancellable)
        let sut = LeagueDetailViewModel(league: .mock(), useCase: useCaseMock)

        // When
        await sut.fetchTeams()

        // Then
        wait(for: [taskExpectation])
        XCTAssertEqual(useCaseMock.invokedFetchCount, 1, "wrong useCase should called once")
        XCTAssertEqual(sut.error?.localizedDescription, "Fetching data error", "wrong error should be Fetching data error")
        XCTAssertFalse(sut.isLoading, "wrong isLoading should be false")
    }
}

private final class LeagueDetailUseCaseMock: LeagueDetailUseCaseProtocol {
    @Published private(set) var invokedFetch = false
    var invokedFetchCount = 0
    var stubbedFetchResult: [TeamEntity]?

    func execute(league: String) async throws -> [TeamEntity] {
        defer {
            invokedFetch = true
        }
        invokedFetchCount += 1
        guard let result = self.stubbedFetchResult else {
            throw PSError.errorDataFetch
        }
        return result
    }
}
