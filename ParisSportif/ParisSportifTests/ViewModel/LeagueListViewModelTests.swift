//
//  LeagueListViewModelTests.swift
//  ParisSportifTests
//
//  Created by reda.mimouni.ext on 25/12/2023.
//

import Foundation
import XCTest
import APICaller
@testable import ParisSportif

final class LeagueListViewModelTests: XCTestCase {
    @MainActor
    func test_isLoading_shouldBeTrue() async {
        // Given
        let sut = LeagueListViewModel()

        // When
        let isLoading = sut.isLoading

        // Then
        XCTAssertTrue(isLoading, "wrong isLoading should be true")
        XCTAssertNil(sut.error, "Error should be nil")
    }

    @MainActor 
    func test_fetchLeagueList_shouldSuccess() async {
        // Given
        let useCaseMock = LeagueListUseCaseMock()
        useCaseMock.stubbedFetchResult = [.mock()]
        let sut = LeagueListViewModel(useCase: useCaseMock)

        // When
        await sut.fetchLeagueList()

        // Then
        let suggestions = sut.suggestions
        XCTAssertEqual(useCaseMock.invokedFetchCount, 1, "wrong useCase should called once")
        XCTAssertEqual(suggestions, [.mock()], "wrong suggestions should equal to mock")
        XCTAssertNil(sut.error, "Error should be nil")
        XCTAssertFalse(sut.isLoading, "wrong isLoading should be false")
    }

    @MainActor 
    func test_fetchLeagueList_shouldSetError() async {
        // Given
        let useCaseMock = LeagueListUseCaseMock()
        let sut = LeagueListViewModel(useCase: useCaseMock)

        // When
        await sut.fetchLeagueList()

        // Then
        XCTAssertEqual(useCaseMock.invokedFetchCount, 1, "wrong useCase should called once")
        XCTAssertEqual(sut.error?.localizedDescription, "Fetching data error", "wrong error should be Fetching data error")
        XCTAssertFalse(sut.isLoading, "wrong isLoading should be false")
    }

    @MainActor 
    func test_searchText_givenS_shouldReturnSpanishLeague() async {
        // Given
        let useCaseMock = LeagueListUseCaseMock()
        useCaseMock.stubbedFetchResult = [.mock(), .mock(strLeague: "Spanish League")]
        let sut = LeagueListViewModel(useCase: useCaseMock)

        // When
        await sut.fetchLeagueList()
        sut.searchText = "S"

        // Then
        let suggestions = sut.suggestions
        XCTAssertEqual(useCaseMock.invokedFetchCount, 1, "wrong useCase should called once")
        XCTAssertEqual(suggestions, [.mock(nameLeague: "Spanish League")], "wrong suggestions should equal to mock")
        XCTAssertNil(sut.error, "Error should be nil")
        XCTAssertFalse(sut.isLoading, "wrong isLoading should be false")
    }

    @MainActor 
    func test_filterLeagueList_givenQ_shouldReturnNoSuggestions() async {
        // Given
        let useCaseMock = LeagueListUseCaseMock()
        useCaseMock.stubbedFetchResult = [.mock(), .mock(strLeague: "Spanish League")]
        let sut = LeagueListViewModel(useCase: useCaseMock)

        // When
        await sut.fetchLeagueList()
        sut.searchText = "Q"

        // Then
        let suggestions = sut.suggestions
        XCTAssertEqual(useCaseMock.invokedFetchCount, 1, "wrong useCase should called once")
        XCTAssertTrue(suggestions.isEmpty, "wrong suggestions should be empty")
        XCTAssertNil(sut.error, "Error should be nil")
        XCTAssertFalse(sut.isLoading, "wrong isLoading should be false")
    }
}

@MainActor
private final class LeagueListUseCaseMock: LeagueListUseCaseProtocol {
    var invokedFetchCount = 0
    var stubbedFetchResult: [LeagueEntity]?

    func execute() async throws -> [LeagueEntity] {
        invokedFetchCount += 1
        guard let result = self.stubbedFetchResult else {
            throw PSError.errorDataFetch
        }
        return result
    }
}
