#  Wordle

https://coding-challenges.jl-engineering.net/challenges/challenge-35/

## Part One - recreating the test in the game

Wordle is a game where the user gets 6 attempts to guess a 5-letter word. After each guess, each of the five letters are highlighted in:
🟩 Green if you have the right letter in the right position
🟨 Yellow if you have a correct letter but in the wrong position
⬜ Grey if you have an incorrect letter 
This continues until the word is guessed correctly (i.e. all letters are green) or when all six guesses are exhausted.

For example, imagine that the word (unknown to the player) is piece:

The player guesses eerie - the result is 🟨⬜⬜🟨🟩 (Note: The first e is yellow, but the second is grey, because there’s only one e in the correct word that isn’t already in the right place)
The player guesses about - the result is ⬜⬜⬜⬜⬜ (Note: There’s no constraint stopping you guessing words which have already been ruled out by previous results)
The player guesses siege - the result is ⬜🟩🟩⬜🟩
The player guesses niece - the result is ⬜🟩🟩🟩🟩
The player guesses piece - the result is 🟩🟩🟩🟩🟩 and the game is won
For this challenge you’ll be writing a function which takes two string arguments for the guess and the correct word, and returns an array (or list, or similar) of the names of the colours spelled out, in capital letters - so for instance get_result('eerie','piece') should return ['YELLOW','GREY','GREY','YELLOW','GREEN']



