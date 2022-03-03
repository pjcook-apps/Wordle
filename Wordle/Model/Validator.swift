import Foundation

public struct Validator {
    public typealias Result = [ResultValue]
    
    public func validate(_ input: String, answer: String) throws -> Result {
        guard !answer.isEmpty else {
            throw InvalidLength(message: "Expected answer cannot be blank")
        }
        
        guard answer.count == 5 else {
            throw InvalidLength(message: "Answer should be 5 characters not: \(answer.count)")
        }
        
        guard input.count == answer.count else {
            throw InvalidLength(message: "Input does not contain enough characters. Found: \(input.count), expected: \(answer.count)")
        }
        
        let arrayInput = input.map { String($0) }
        let arrayAnswer = answer.map { String($0) }
        
        var result: Result = Array(repeating: .invalid, count: answer.count)
        var remaining = arrayAnswer
        
        func remove(_ value: String) {
            if let index = remaining.firstIndex(of: value) {
                remaining.remove(at: index)
            }
        }
        
        for i in (0..<answer.count) {
            let a = arrayInput[i]
            let b = arrayAnswer[i]
            if a == b {
                result[i] = .validLocation
                remove(a)
            }
        }
        
        for i in (0..<answer.count) {
            let a = arrayInput[i]
            let b = arrayAnswer[i]
            if a != b, remaining.contains(a) {
                result[i] = .valid
                remove(a)
            }
        }
        
        return result
    }
}

extension Validator {
    public enum ResultValue {
        case invalid, valid, validLocation
    }
    
    public struct InvalidLength: Error {
        public let message: String
    }
}
