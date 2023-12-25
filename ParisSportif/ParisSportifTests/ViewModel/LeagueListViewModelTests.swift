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

    func test_viewModelState_shouldBeLoading() async {
        // Given
        let sut = LeagueListViewModel()

        // When
        let viewModelState = sut.viewModelState

        // Then
        XCTAssertEqual(viewModelState, .loading, "wrong viewModelState should be .loading")
        XCTAssertNil(sut.error, "Error should be nil")
    }

    func test_viewModelState_shouldBeSuccess() {
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
        let viewModelState = sut.viewModelState
        XCTAssertEqual(useCaseMock.invokedFetchCount, 1, "wrong useCase should called once")
        XCTAssertEqual(viewModelState, .success(suggestions: [.mock()]), "wrong viewModelState should be .success")
        XCTAssertNil(sut.error, "Error should be nil")
    }

    func test_viewModelState_shouldBeFailure() {
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
        let viewModelState = sut.viewModelState
        XCTAssertEqual(useCaseMock.invokedFetchCount, 1, "wrong useCase should called once")
        XCTAssertEqual(viewModelState, .failure, "wrong viewModelState should be .failure")
        XCTAssertEqual(sut.error?.localizedDescription, "Fetching data error", "wrong error should be Fetching data error")
    }

    func test_filterLeagueList_givenS_shouldReturnSpanishLeague() {
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
        sut.filterLeagueList(with: "S")

        // Then
        let viewModelState = sut.viewModelState
        XCTAssertEqual(useCaseMock.invokedFetchCount, 1, "wrong useCase should called once")
        XCTAssertEqual(viewModelState, .success(suggestions: [.mock(nameLeague: "Spanish League")]), "wrong viewModelState should be .success")
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
        sut.filterLeagueList(with: "Q")

        // Then
        let viewModelState = sut.viewModelState
        XCTAssertEqual(useCaseMock.invokedFetchCount, 1, "wrong useCase should called once")
        XCTAssertEqual(viewModelState, .empty(message: "0 results, try another key word"), "wrong viewModelState should be .empty")
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
