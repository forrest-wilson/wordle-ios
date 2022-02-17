//
//  StringExtension.swift
//  Wordle
//
//  Created by Forrest Wilson-Jennings on 17/02/22.
//

/// Allows for string[index] type syntax
extension String {
  subscript(i: Int) -> String {
    return String(self[index(startIndex, offsetBy: i)])
  }
}
