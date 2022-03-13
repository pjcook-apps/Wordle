import Foundation

typealias Word = String

struct WordList {
    let words: [Word]
}

extension WordList {
    static func load() throws -> WordList {
        guard let url = Bundle(for: Bundler.self).url(forResource: "WordList", withExtension: "txt") else {
            throw MissingFile(filename: "WordList.txt")
        }
        
        let input = try String(contentsOf: url)
        let clean = input.split(separator: "\n").map { $0.trimmingCharacters(in: .whitespaces) }
        return WordList(words: clean)
    }
    
    public struct MissingFile: Error {
        public let filename: String
    }
}

class Bundler {}
