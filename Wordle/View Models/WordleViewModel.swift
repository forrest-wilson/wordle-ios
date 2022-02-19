//
//  WordleViewModel.swift
//  Wordle
//
//  Created by Forrest Wilson-Jennings on 17/02/22.
//

import Foundation
import SwiftUI

class WordleViewModel: ObservableObject {
  @Published var wordList: [String]?
  @Published var randomWord: String?
  @Published var remainingAttempts: Int = 5
  
  @Published var gameState: GameState = .InProgress
  
  @Published public var guesses: [String] = []
  
  @Published public var message: String = ""
  
  @Published var showMessageAlert: Bool = false {
    didSet {
      //
      // If the showMessageAlert is set to true,
      // wait for a set number of seconds and then set to false.
      //
      // This will ensure UI is temporary
      //

      if showMessageAlert {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
          self.showMessageAlert = false
        }
      }
    }
  }
  
  init() {
    self.loadWordList()
    self.pickRandomWord()
  }
  
  private func loadWordList() -> Void {
    if let path = Bundle.main.path(forResource: "wordList", ofType: "json") {
      do {
        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let jsonResult = try JSONSerialization.jsonObject(with: data, options: []) as! [String]
        
        wordList = jsonResult
      } catch {
        print("Error while attempting to parse JSON file")
      }
    }
  }
  
  private func pickRandomWord() -> Void {
    guard let wordList = wordList else { return }
    randomWord = wordList.randomElement()
    
    #if DEBUG
    print(randomWord!)
    #endif
  }
  
  public func checkWord(_ word: String) -> Void {
    // Convert all comparisons to lowecase
    let caseCheckedWord = word.lowercased()
    guard let caseCheckedRandomWord = randomWord?.lowercased() else { return }
    
    // If the word is less than 5 characters,
    // show a message to the user and exit the function
    if caseCheckedWord.count < 5 {
      message = "Word is too short"
      showMessageAlert = true
      return
    }
    
    // If the wordList doesn't contain the caseCheckedWord,
    // show a message to the user and exit the function
    if !wordList!.contains(caseCheckedWord) {
      message = "Word doesn't exist"
      showMessageAlert = true
      return
    }
    
    // Reduce the number of remaining attempts and add the word to the list of guesses
    remainingAttempts -= 1
    guesses.append(word)
    
    // If the user has correctly guessed the word, update the gameState
    if caseCheckedWord == caseCheckedRandomWord {
      gameState = .Won
      return
    }
    
    // If there are less than or equal to 0 remaining attempts, the player has lost the game
    if remainingAttempts <= 0 {
      gameState = .Lost
      return
    }
  }
  
  private func isLetterCorrect(_ letter: String, _ index: Int) -> Bool {
    let caseCheckedLetter = letter.uppercased()
    let caseCheckedLetterFromRandomWord = randomWord?[index].uppercased()
    
    return caseCheckedLetter == caseCheckedLetterFromRandomWord
  }
  
  private func isLetterInWord(_ letter: String) -> Bool {
    let caseCheckedLetter = letter.uppercased()
    let caseCheckedWord = randomWord?.uppercased()
    let letterIsInWord = caseCheckedWord?.contains(caseCheckedLetter)
    
    return letterIsInWord!
  }
  
  public func getColorForLetter(_ letter: String, _ index: Int) -> Color? {
    if isLetterCorrect(letter, index) {
      return .green
    }
    
    if isLetterInWord(letter) {
      return .yellow
    }
    
    return nil
  }
  
  public func pickNewWord() -> Void {
    guesses = []
    remainingAttempts = 5
    gameState = .InProgress
    
    pickRandomWord()
  }
}
