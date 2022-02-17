//
//  TextBindingManager.swift
//  Wordle
//
//  Created by Forrest Wilson-Jennings on 17/02/22.
//

import Foundation

class TextBindingManager: ObservableObject {
  @Published var text = "" {
    didSet {
      if text.count > characterLimit && oldValue.count <= characterLimit {
        text = oldValue
      }
    }
  }
  
  let characterLimit: Int
  
  init(_ limit: Int = 1) {
    characterLimit = limit
  }
}
