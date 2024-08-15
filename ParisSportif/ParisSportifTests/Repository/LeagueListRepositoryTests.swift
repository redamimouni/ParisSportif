//
//  LeagueListRepositoryTests.swift
//  ParisSportifTests
//
//  Created by reda.mimouni.ext on 25/12/2023.
//

import Foundation
import XCTest
import APICaller
@testable import ParisSportif

class LeagueListRepositoryTests: XCTestCase {
    
    @MainActor
    func test_fetchLeagueList_shouldReturnSuccess() async throws {
        // Given
        let apiCallerMock = APICallerMock()
        apiCallerMock.stubbedFetchResult = LeagueListDTO.mock()
        let sut = LeagueListRepository(apiCaller: apiCallerMock)

        // When
        do {
            let result = try await sut.fetchLeagueList()

            // Then
            XCTAssertEqual(result, [.mock], "wrong should be equal to LeagueDTO mock")
        } catch {
            XCTFail("Should not throw error")
        }
    }

    @MainActor
    func test_fetchLeagueList_shouldThrowParsingDataError() async throws {
        // Given
        let apiCallerMock = APICallerMock()
        let sut = LeagueListRepository(apiCaller: apiCallerMock)

        // When
        do {
            let _ = try await sut.fetchLeagueList()

            // Then
            XCTFail("Should throw error")
        } catch {
            XCTAssertEqual(error.localizedDescription, "HTTP request error", "message should be HTTP request error")
        }
    }
}

@MainActor
final class APICallerMock: APICallerProtocol {
    var stubbedFetchResult: Decodable?

    func perform<T>(_ request: URLRequest) async throws -> T where T : Decodable {
        guard let result = stubbedFetchResult else { throw PSError.httpRequestError}
        return result as! T
    }
}
