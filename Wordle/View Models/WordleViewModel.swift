//
//  WordleViewModel.swift
//  Wordle
//
//  Created by Forrest Wilson-Jennings on 17/02/22.
//

import Foundation

class WordleViewModel: ObservableObject {
  @Published var wordList: [String]?
  @Published var randomWord: String?
  
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
  
  public func isWordCorrect(_ word: String) -> Bool {
    let caseCheckedWord = word.lowercased()
    guard let caseCheckedRandomWord = randomWord?.lowercased() else { return false }
    
    return caseCheckedWord == caseCheckedRandomWord
  }
}
