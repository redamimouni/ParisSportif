//
//  APIRequestTests.swift
//  ParisSportifTests
//
//  Created by reda.mimouni.ext on 29/12/2023.
//

import Foundation
import XCTest
@testable import ParisSportif

final class APIRequestTests: XCTestCase {
    func test_apiRequestListing_shouldReturnRightURL() throws {
        // Given
        let sut = APIEndpoints.listing
        let expectedURL = try XCTUnwrap(URL(string: "https://www.thesportsdb.com/api/v1/json/50130162/all_leagues.php"))
        let expectedURLRequest = URLRequest(url: expectedURL)

        // When
        let request = URLRequest.buildRequest(from: sut)

        // Then
        XCTAssertEqual(request, expectedURLRequest, "wrong request should equal to expected")
    }

    func test_apiRequestDetail_shouldReturnRightURL() throws {
        // Given
        let sut = APIEndpoints.searchAllTeams(for: "Liga")
        let expectedURL = try XCTUnwrap(URL(string: "https://www.thesportsdb.com/api/v1/json/50130162/search_all_teams.php?l=Liga"))
        let expectedURLRequest = URLRequest(url: expectedURL)

        // When
        let request = URLRequest.buildRequest(from: sut)


        // Then
        XCTAssertEqual(request, expectedURLRequest, "wrong request should equal to expected")
    }
}
