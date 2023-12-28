//
//  LeagueDetailRepositoryTests.swift
//  ParisSportifTests
//
//  Created by reda.mimouni.ext on 28/12/2023.
//

import Foundation
import XCTest
@testable import ParisSportif

final class LeagueDetailRepositoryTests: XCTestCase {
    func test_fetchLeagueDetail_shouldReturnSuccess() async throws {
        // Given
        let resultJson = #"{"teams":[{"idTeam": "133899", "strTeam": "AGF Aarhus", "strTeamBadge": "https://www.thesportsdb.com/images/media/team/badge/vxuuts1473535487.png"}]}"#
        let data = try XCTUnwrap(resultJson.data(using: .utf8), "fail to unwrap")
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
                    strTeamBadge: "www.test.fr/image.jpg"
                )],
                "wrong should be equal to LeagueDetailDTO mock")
        } catch {
            XCTFail("fetchLeagueDetail Should not throw error")
        }
    }

    func test_fetchLeagueDetail_shouldThrowParsingDataError() async throws {
        // Given
        let resultJson = #"{"toto":[{"idTeam": "133899", "strTeam": "AGF Aarhus", "strTeamBadge": "https://www.thesportsdb.com/images/media/team/badge/vxuuts1473535487.png"}]}"#
        let data = try XCTUnwrap(resultJson.data(using: .utf8), "fail to unwrap")
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
