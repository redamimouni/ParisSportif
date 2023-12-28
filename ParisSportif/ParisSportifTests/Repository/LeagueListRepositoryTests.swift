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
        let sessionMock = URLSessionMock()
        sessionMock.stubbedFetchResult = (data, URLResponse())
        let sut = LeagueListRepository(urlSession: sessionMock)

        // When
        do {
            let result = try await sut.fetchLeagueList()

            // Then
            XCTAssertEqual(result, .mock(), "wrong should be equal to LeagueListDTO mock")
        } catch {
            XCTFail("Should not throw error")
        }
    }

    func test_fetchLeagueList_shouldThrowParsingDataError() async throws {
        // Given
        let resultJson = #"{"lea": [{"idLeague":"4328","strLeague":"English Premier League","strSport":"Soccer","strLeagueAlternate":"Premier League, EPL"}]}"#
        let data = try XCTUnwrap(resultJson.data(using: .utf8), "fail to unwrap")
        let sessionMock = URLSessionMock()
        sessionMock.stubbedFetchResult = (data, URLResponse())
        let sut = LeagueListRepository(urlSession: sessionMock)

        // When
        do {
            let _ = try await sut.fetchLeagueList()

            // Then
            XCTFail("Should throw error")
        } catch {
            XCTAssertEqual(error.localizedDescription, "Parsing data error", "message should be Parsing data error")
        }
    }

    func test_fetchLeagueList_shouldThrowFetchingDataError() async throws {
        // Given
        let sessionMock = URLSessionMock()
        let sut = LeagueListRepository(urlSession: sessionMock)

        // When
        do {
            let _ = try await sut.fetchLeagueList()

            // Then
            XCTFail("Should throw error")
        } catch {
            XCTAssertEqual(error.localizedDescription, "Fetching data error", "message should be Fetching data error")
        }
    }
}

final class URLSessionMock: URLSessionProtocol {
    var stubbedFetchResult: (Data, URLResponse)?

    func data(with request: URLRequest) async throws -> (Data, URLResponse) {
        guard let result = stubbedFetchResult else { throw URLError.init(.badServerResponse) }
        return result
    }
}
