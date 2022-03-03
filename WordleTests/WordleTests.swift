import XCTest
@testable import Wordle

class WordleTests: XCTestCase {
    func test_validate() throws {
        let answer = "piece"
        let inputs: [String: Validator.Result] = [
            "eerie": [.valid, .invalid, .invalid, .valid, .validLocation],
            "about": [.invalid, .invalid, .invalid, .invalid, .invalid],
            "siege": [.invalid, .validLocation, .validLocation, .invalid, .validLocation],
            "niece": [.invalid, .validLocation, .validLocation, .validLocation, .validLocation],
            "piece": [.validLocation, .validLocation, .validLocation, .validLocation, .validLocation]
        ]
        
        let validator = Validator()

        for input in inputs {
            let userInput = input.key
            let expectedResult = input.value
            
            let result = try validator.validate(userInput, answer: answer)
            XCTAssertEqual(answer.count, userInput.count)
            XCTAssertEqual(expectedResult, result)
        }
    }
    
    func test_vaildate_empty() throws {
        let validator = Validator()
        let input = ""
        let answer = ""
        
        XCTAssertThrowsError(try validator.validate(input, answer: answer), "Failed", { error in
            XCTAssertTrue(error is Validator.InvalidLength)
            XCTAssertEqual("Expected answer cannot be blank", (error as? Validator.InvalidLength)?.message)
        })
    }
    
    func test_vaildate_answerWrongLength() throws {
        let validator = Validator()
        let input = ""
        let answer = "1"
        
        XCTAssertThrowsError(try validator.validate(input, answer: answer), "Failed", { error in
            XCTAssertTrue(error is Validator.InvalidLength)
            XCTAssertEqual("Answer should be 5 characters not: \(answer.count)", (error as? Validator.InvalidLength)?.message)
        })
    }
    
    func test_vaildate_answerAndInputLength_noMatch() throws {
        let validator = Validator()
        let input = ""
        let answer = "12345"
        
        XCTAssertThrowsError(try validator.validate(input, answer: answer), "Failed", { error in
            XCTAssertTrue(error is Validator.InvalidLength)
            XCTAssertEqual("Input does not contain enough characters. Found: \(input.count), expected: \(answer.count)", (error as? Validator.InvalidLength)?.message)
        })
    }
}
