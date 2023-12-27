//
//  LeagueListViewModelTests.swift
//  ParisSportifTests
//
//  Created by reda.mimouni.ext on 25/12/2023.
//

import Foundation
import XCTest
import Combine
@testable import ParisSportif

class LeagueListViewModelTests: XCTestCase {
    private var cancellable = Set<AnyCancellable>()

    func test_isLoading_shouldBeTrue() async {
        // Given
        let sut = LeagueListViewModel()

        // When
        let isLoading = sut.isLoading

        // Then
        XCTAssertTrue(isLoading, "wrong isLoading should be true")
        XCTAssertNil(sut.error, "Error should be nil")
    }

    func test_fetchLeagueList_shouldSuccess() {
        // Given
        let taskExpectation = XCTestExpectation()
        let useCaseMock = LeagueUseCaseMock()
        useCaseMock.stubbedFetchResult = [.mock()]
        let sut = LeagueListViewModel(useCase: useCaseMock)
        useCaseMock.$invokedFetch
            .filter { $0 }
            .sink { _ in
                Task {
                    taskExpectation.fulfill()
                }
            }.store(in: &cancellable)

        // When
        sut.fetchLeagueList()

        // Then
        wait(for: [taskExpectation])
        let suggestions = sut.suggestions
        XCTAssertEqual(useCaseMock.invokedFetchCount, 1, "wrong useCase should called once")
        XCTAssertEqual(suggestions, [.mock()], "wrong suggestions should equal to mock")
        XCTAssertNil(sut.error, "Error should be nil")
    }

    func test_fetchLeagueList_shouldSetError() {
        // Given
        let taskExpectation = XCTestExpectation()
        let useCaseMock = LeagueUseCaseMock()
        let sut = LeagueListViewModel(useCase: useCaseMock)
        useCaseMock.$invokedFetch
            .filter { $0 }
            .sink { _ in
                Task {
                    taskExpectation.fulfill()
                }
            }.store(in: &cancellable)

        // When
        sut.fetchLeagueList()

        // Then
        wait(for: [taskExpectation])
        XCTAssertEqual(useCaseMock.invokedFetchCount, 1, "wrong useCase should called once")
        XCTAssertEqual(sut.error?.localizedDescription, "Fetching data error", "wrong error should be Fetching data error")
    }

    func test_searchText_givenS_shouldReturnSpanishLeague() {
        // Given
        let taskExpectation = XCTestExpectation()
        let useCaseMock = LeagueUseCaseMock()
        useCaseMock.stubbedFetchResult = [.mock(), .mock(strLeague: "Spanish League")]
        let sut = LeagueListViewModel(useCase: useCaseMock)
        useCaseMock.$invokedFetch
            .filter { $0 }
            .sink { _ in
                Task {
                    taskExpectation.fulfill()
                }
            }.store(in: &cancellable)

        // When
        sut.fetchLeagueList()
        wait(for: [taskExpectation])
        sut.searchText = "S"

        // Then
        let suggestions = sut.suggestions
        XCTAssertEqual(useCaseMock.invokedFetchCount, 1, "wrong useCase should called once")
        XCTAssertEqual(suggestions, [.mock(nameLeague: "Spanish League")], "wrong suggestions should equal to mock")
        XCTAssertNil(sut.error, "Error should be nil")
    }

    func test_filterLeagueList_givenQ_shouldReturnNoSuggestions() {
        // Given
        let taskExpectation = XCTestExpectation()
        let useCaseMock = LeagueUseCaseMock()
        useCaseMock.stubbedFetchResult = [.mock(), .mock(strLeague: "Spanish League")]
        let sut = LeagueListViewModel(useCase: useCaseMock)
        useCaseMock.$invokedFetch
            .filter { $0 }
            .sink { _ in
                Task {
                    taskExpectation.fulfill()
                }
            }.store(in: &cancellable)

        // When
        sut.fetchLeagueList()
        wait(for: [taskExpectation])
        sut.searchText = "Q"

        // Then
        let suggestions = sut.suggestions
        XCTAssertEqual(useCaseMock.invokedFetchCount, 1, "wrong useCase should called once")
        XCTAssertTrue(suggestions.isEmpty, "wrong suggestions should be empty")
        XCTAssertNil(sut.error, "Error should be nil")
    }
}

private class LeagueUseCaseMock: LeagueListUseCaseProtocol {
    @Published private(set) var invokedFetch = false
    var invokedFetchCount = 0
    var stubbedFetchResult: [LeagueEntity]?

    func fetchLeagueList() async throws -> [LeagueEntity] {
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

extension LeagueEntity {
    static func mock(strLeague: String = "Ligue 1") -> LeagueEntity {
        .init(idLeague: 1, strLeague: strLeague)
    }
}

extension LeagueModel {
    static func mock(nameLeague: String = "Ligue 1") -> LeagueModel {
        .init(idLeague: 1, nameLeague: nameLeague)
    }
}
