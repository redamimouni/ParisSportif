//
//  LeagueDetailRepositoryTests.swift
//  ParisSportifTests
//
//  Created by reda.mimouni.ext on 28/12/2023.
//

import Foundation
import XCTest
import APICaller
@testable import ParisSportif

final class LeagueDetailRepositoryTests: XCTestCase {

    @MainActor
    func test_fetchLeagueDetail_shouldReturnSuccess() async throws {
        // Given
        let apiCallerMock = APICallerMock()
        apiCallerMock.stubbedFetchResult = LeagueDetailDTO.mock()
        let sut = LeagueDetailRepository(apiCaller: apiCallerMock)

        // When
        do {
            let result = try await sut.fetchLeagueDetail(for: "Ligue 1")

            // Then
            XCTAssertEqual(
                result,
                [.mock(
                    idTeam: "1",
                    strTeam: "PSG",
                    strBadge: "https://www.thesportsdb.com/images/media/team/badge/rwqrrq1473504808.png"
                )],
                "wrong should be equal to LeagueDetailDTO mock")
        } catch {
            XCTFail("fetchLeagueDetail Should not throw error")
        }
    }

    @MainActor
    func test_fetchLeagueDetail_shouldThrowParsingDataError() async throws {
        // Given
        let apiCallerMock = APICallerMock()
        let sut = LeagueDetailRepository(apiCaller: apiCallerMock)

        // When
        do {
            let _ = try await sut.fetchLeagueDetail(for: "Ligue 1")

            // Then
            XCTFail("Should not throw error")
        } catch {
            XCTAssertEqual(error.localizedDescription, "Parsing data error", "message should be Parsing data error")
        }
    }
}
