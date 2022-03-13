//
//  WordlePart2Tests.swift
//  WordleTests
//
//  Created by PJ on 13/03/2022.
//

import XCTest
@testable import Wordle

class WordlePart2Tests: XCTestCase {
    func test_cheater1() throws {
        let cheater = try Cheat()
        let guesses = ["eerie", "about"]
        let answer = "piece"
        let possibleWords = try cheater.possibleWords(guesses: guesses, answer: answer)
        XCTAssertEqual(19, possibleWords.count)
    }
    
    func test_cheater2() throws {
        let cheater = try Cheat()
        let guesses = ["eerie", "about", "piece"]
        let answer = "piece"
        let possibleWords = try cheater.possibleWords(guesses: guesses, answer: answer)
        XCTAssertEqual(1, possibleWords.count)
    }
    
    func test_cheater3() throws {
        let cheater = try Cheat()
        let guesses = ["eerie", "about", "dcswm"]
        let answer = "piece"
        let possibleWords = try cheater.possibleWords(guesses: guesses, answer: answer)
        XCTAssertEqual(2, possibleWords.count)
    }
    
    func test_cheater4() throws {
        let cheater = try Cheat()
        let guesses = ["eerie", "about", "dcswm", "niece"]
        let answer = "piece"
        let possibleWords = try cheater.possibleWords(guesses: guesses, answer: answer)
        XCTAssertEqual(1, possibleWords.count)
    }
}
