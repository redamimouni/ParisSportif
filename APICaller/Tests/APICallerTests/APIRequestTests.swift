//
//  APIRequestTests.swift
//  ParisSportifTests
//
//  Created by reda.mimouni.ext on 29/12/2023.
//

import Foundation
import XCTest
@testable import APICaller

final class APIRequestTests: XCTestCase {
    func test_apiRequestListing_shouldReturnRightURL() throws {
        // Given
        let expectedURL = try XCTUnwrap(URL(string: "https://www.thesportsdb.com/api/v1/json/50130162/all_leagues.php"))
        let expectedURLRequest = URLRequest(url: expectedURL)

        // When
        let request = URLRequest.list

        // Then
        XCTAssertEqual(request, expectedURLRequest, "wrong request should equal to expected")
    }

    func test_apiRequestDetail_shouldReturnRightURL() throws {
        // Given
        let expectedURL = try XCTUnwrap(URL(string: "https://www.thesportsdb.com/api/v1/json/50130162/search_all_teams.php?l=Liga"))
        let expectedURLRequest = URLRequest(url: expectedURL)

        // When
        let request = URLRequest.searchAllTeams(name: "Liga")

        // Then
        XCTAssertEqual(request, expectedURLRequest, "wrong request should equal to expected")
    }
}
