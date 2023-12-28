//
//  LeagueListRepositoryTests.swift
//  ParisSportifTests
//
//  Created by reda.mimouni.ext on 25/12/2023.
//

import Foundation
import XCTest
@testable import ParisSportif

class LeagueListRepositoryTests: XCTestCase {
    
    func test_fetchLeagueList_shouldReturnSuccess() async throws {
        // Given
        let resultJson = #"{"leagues": [{"idLeague":"4328","strLeague":"English Premier League","strSport":"Soccer","strLeagueAlternate":"Premier League, EPL"}]}"#
        let data = try XCTUnwrap(resultJson.data(using: .utf8), "fail to unwrap")
        let apiCallerMock = APICallerMock()
        apiCallerMock.stubbedFetchResult = LeagueListDTO.mock()
        let sut = LeagueListRepository(apiCaller: apiCallerMock)

        // When
        do {
            let result = try await sut.fetchLeagueList()

            // Then
            XCTAssertEqual(result, [.mock()], "wrong should be equal to LeagueDTO mock")
        } catch {
            XCTFail("Should not throw error")
        }
    }

    func test_fetchLeagueList_shouldThrowParsingDataError() async throws {
        // Given
        let resultJson = #"{"lea": [{"idLeague":"4328","strLeague":"English Premier League","strSport":"Soccer","strLeagueAlternate":"Premier League, EPL"}]}"#
        let data = try XCTUnwrap(resultJson.data(using: .utf8), "fail to unwrap")
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

final class APICallerMock: APICallerProtocol {
    var stubbedFetchResult: Decodable?

    func perform<T>(_ request: URLRequest) async throws -> T where T : Decodable {
        guard let result = stubbedFetchResult else { throw PSError.httpRequestError}
        return result as! T
    }
}

extension LeagueDTO {
    static func mock() -> LeagueDTO {
        return .init(idLeague: "4328",
                     strLeague: "English Premier League",
                     strSport: "Soccer",
                     strLeagueAlternate: "Premier League, EPL")
    }
}
