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
  
  @Published public var guesses: [String] = []
  
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
  }
  
  public func checkWord(_ word: String) -> Void {
    let caseCheckedWord = word.lowercased()
    guard let caseCheckedRandomWord = randomWord?.lowercased() else { return }
    
    if !wordList!.contains(caseCheckedWord) {
      print("word doesnt exist")
      return
    }
    
    // TODO: Stop word from being added to guess list if remainingAttempts is less than 1
    
    remainingAttempts -= 1
    guesses.append(word)
    
    if caseCheckedWord == caseCheckedRandomWord {
      // TODO: Do something that shows that the user has guessed correctly
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
      return Color.green
    }
    
    if isLetterInWord(letter) {
      return .yellow
    }
    
    return nil
  }
}
