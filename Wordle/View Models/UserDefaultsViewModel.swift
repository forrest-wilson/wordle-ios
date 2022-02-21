//
//  UserDefaultsViewModel.swift
//  Wordle
//
//  Created by Forrest Wilson-Jennings on 21/02/22.
//

import Foundation

class UserDefaultsViewModel: ObservableObject {
  public var currentScore: Int {
    get {
      return UserDefaults().integer(forKey: "CurrentScore")
    }
    
    set(value) {
      return UserDefaults().set(value, forKey: "CurrentScore")
    }
  }

  public var highestScore: Int {
    get {
      return UserDefaults().integer(forKey: "HighestScore")
    }
    
    set(value) {
      UserDefaults().set(value, forKey: "HighestScore")
    }
  }
  
  public func gameWon() -> Void {
    currentScore += 1
    
    if currentScore > highestScore {
      highestScore = currentScore
    }
  }
}
