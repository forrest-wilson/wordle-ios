//
//  LetterBox.swift
//  Wordle
//
//  Created by Forrest Wilson-Jennings on 17/02/22.
//

import SwiftUI

struct LetterBox: View {
  var text: String
  var color: Color?
  var borderColor: Color = .white

  var body: some View {
    Text(text)
      .font(.headline)
      .padding()
      .frame(minWidth: 0, maxWidth: .infinity)
      .frame(height: 60)
      .background(color)
      .cornerRadius(10)
      .overlay(
        RoundedRectangle(cornerRadius: 10)
          .stroke(borderColor, lineWidth: 1)
      )
  }
}

struct LetterBox_Previews: PreviewProvider {
  static var previews: some View {
    LetterBox(text: "Default Text", color: .clear)
      .preferredColorScheme(.dark)
  }
}
