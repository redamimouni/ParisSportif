//
//  APICallerTests.swift
//  ParisSportifTests
//
//  Created by reda.mimouni.ext on 28/12/2023.
//

import Foundation
import XCTest
@testable import ParisSportif

final class APICallerTests: XCTestCase {
    func test_perform_shouldReturnLeagueListDTO() async throws {
        // Given
        let resultJson = #"{"leagues": [{"idLeague":"4328","strLeague":"English Premier League","strSport":"Soccer","strLeagueAlternate":"Premier League, EPL"}]}"#
        let sessionMock = URLSessionMock()
        let data = try XCTUnwrap(resultJson.data(using: .utf8), "fail to unwrap")
        let responseMock = HTTPURLResponse(url: .init(string: "www.image.fr")!, statusCode: 200, httpVersion: nil, headerFields: nil)! as URLResponse
        sessionMock.stubbedFetchResult = (data, responseMock)
        let sut = APICaller(urlSession: sessionMock)

        // When
        do {
            let request = try XCTUnwrap(URLRequest.urlRequestFrom(urlString: APIEndpoints.listing))
            let result: LeagueListDTO = try await sut.perform(request)

            // Then
            XCTAssertEqual(result, .mock(), "wrong should be equal to LeagueListDTO mock")
        } catch {
            XCTFail("Should not throw error \(error)")
        }
    }

    func test_perform_shouldReturnLeagueDetailDTO() async throws {
        // Given
        let resultJson = #"{"teams":[{"idTeam": "1", "strTeam": "PSG", "strTeamBadge": "www.test.fr/image.jpg"}]}"#
        let sessionMock = URLSessionMock()
        let data = try XCTUnwrap(resultJson.data(using: .utf8), "fail to unwrap")
        let responseMock = HTTPURLResponse(url: .init(string: "www.image.fr")!, statusCode: 200, httpVersion: nil, headerFields: nil)! as URLResponse
        sessionMock.stubbedFetchResult = (data, responseMock)
        let sut = APICaller(urlSession: sessionMock)

        // When
        do {
            let request = try XCTUnwrap(URLRequest.urlRequestFrom(urlString: APIEndpoints.listing))
            let result: LeagueDetailDTO = try await sut.perform(request)

            // Then
            XCTAssertEqual(result, .mock(), "wrong should be equal to LeagueDetailDTO mock")
        } catch {
            XCTFail("Should not throw error \(error)")
        }
    }

    func test_perform_leagueList_shouldThrowParsingError() async throws {
        // Given
        let resultJson = #"{"toto":[{"idTeam": "1", "strTeam": "PSG", "strTeamBadge": "www.test.fr/image.jpg"}]}"#
        let sessionMock = URLSessionMock()
        let data = try XCTUnwrap(resultJson.data(using: .utf8), "fail to unwrap")
        let responseMock = HTTPURLResponse(url: .init(string: "www.image.fr")!, statusCode: 200, httpVersion: nil, headerFields: nil)! as URLResponse
        sessionMock.stubbedFetchResult = (data, responseMock)
        let sut = APICaller(urlSession: sessionMock)

        // When
        do {
            let request = try XCTUnwrap(URLRequest.urlRequestFrom(urlString: APIEndpoints.listing))
            let _: LeagueDetailDTO = try await sut.perform(request)

            // Then
            XCTFail("Should throw error")
        } catch {
            XCTAssertEqual(error.localizedDescription, "Parsing data error", "wrong should throw Parsing data error")
        }
    }

    func test_perform_leagueDetail_shouldThrowParsingError() async throws {
        // Given
        let resultJson = #"{"toto": [{"idLeague":"4328","strLeague":"English Premier League","strSport":"Soccer","strLeagueAlternate":"Premier League, EPL"}]}"#
        let sessionMock = URLSessionMock()
        let data = try XCTUnwrap(resultJson.data(using: .utf8), "fail to unwrap")
        let responseMock = HTTPURLResponse(url: .init(string: "www.image.fr")!, statusCode: 200, httpVersion: nil, headerFields: nil)! as URLResponse
        sessionMock.stubbedFetchResult = (data, responseMock)
        let sut = APICaller(urlSession: sessionMock)

        // When
        do {
            let request = try XCTUnwrap(URLRequest.urlRequestFrom(urlString: APIEndpoints.listing))
            let _: LeagueListDTO = try await sut.perform(request)

            // Then
            XCTFail("Should throw error")
        } catch {
            XCTAssertEqual(error.localizedDescription, "Parsing data error", "wrong should throw Parsing data error")
        }
    }

    func test_perform_shouldThrowHttpRequestError() async throws {
        // Given
        let resultJson = #"{"teams":[{"idTeam": "1", "strTeam": "PSG", "strTeamBadge": "www.test.fr/image.jpg"}]}"#
        let sessionMock = URLSessionMock()
        let data = try XCTUnwrap(resultJson.data(using: .utf8), "fail to unwrap")
        sessionMock.stubbedFetchResult = (data, URLResponse())
        let sut = APICaller(urlSession: sessionMock)

        // When
        do {
            let request = try XCTUnwrap(URLRequest.urlRequestFrom(urlString: APIEndpoints.listing))
            let _: LeagueDetailDTO = try await sut.perform(request)

            // Then
            XCTFail("Should throw error")
        } catch {
            XCTAssertEqual(error.localizedDescription, "HTTP request error", "wrong should throw HTTP request error")
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
