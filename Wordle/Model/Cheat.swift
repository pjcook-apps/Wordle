import Foundation

struct Cheat {
    let wordList: WordList
    let validator: Validator
    
    init(_ wordList: WordList? = nil, validator: Validator = Validator()) throws {
        self.wordList = try wordList ?? WordList.load()
        self.validator = validator
    }
    
    func possibleWords(guesses: [String], answer: String) throws -> [Word] {
        let answerCharacters = Set<Character>(answer)
        var exactMatches: [String] = Array(repeating: "", count: answer.count)
        var invalidLetters: Set<Character> = []
        var noMatch: [Int: Set<String>] = [:]
        var validChars: Set<Character> = []
        var multiples: [Character: Int] = [:]
        
        for guess in guesses {
            var guessMultiples: [Character: Int] = [:]
            let result = try validator.validate(guess, answer: answer)
            for i in (0..<result.count) {
                let r = result[i]
                let c = String(guess[i])
                let char = Character(c)
                if r == .validLocation {
                    exactMatches[i] = c
                    validChars.insert(char)
                    guessMultiples[char] = guessMultiples[char, default: 0] + 1
                } else if r == .valid {
                    var noMatches = noMatch[i, default: []]
                    noMatches.insert(c)
                    noMatch[i] = noMatches
                    validChars.insert(char)
                    guessMultiples[char] = guessMultiples[char, default: 0] + 1
                } else {
                    if !answerCharacters.contains(char) {
                        invalidLetters.insert(char)
                    }
                }
            }
            
            for c in guessMultiples.keys {
                multiples[c] = max(multiples[c, default: 0], guessMultiples[c, default: 0])
            }
        }
        
        for c in multiples.keys {
            if multiples[c, default: 0] <= 1 {
                multiples.removeValue(forKey: c)
            }
        }
        
        var possibleWords = wordList.words
            
        possibleWords = possibleWords.filter { word in
            let wordChars = Set<Character>(word)
            if !invalidLetters.isEmpty, !wordChars.intersection(invalidLetters).isEmpty {
                return false
            }
            
            if !validChars.isEmpty, wordChars.intersection(validChars).count != validChars.count {
                return false
            }

            for i in (0..<word.count) {
                let a = exactMatches[i]
                if a != "" && a != word[i] {
                    return false
                } else if let x = noMatch[i], !x.isEmpty, x.contains(String(word[i])) {
                    return false
                }
            }
            
            for key in multiples.keys {
                if word.filter({ $0 == key }).count < multiples[key, default: 0] {
                    return false
                }
            }
            
            return true
        }
        
        return possibleWords
    }
}
