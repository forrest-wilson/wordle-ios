//
//  KeyboardButtonView.swift
//  Wordle
//
//  Created by Forrest Wilson-Jennings on 20/02/22.
//

import SwiftUI

struct KeyboardButtonView: View {
  public var letter: String?
  public var icon: String?
  public var color: Color? = .gray
  public var action: (_ letter: String) -> Void
  
  var body: some View {
    Button {
      action(letter ?? "")
    } label: {
      if icon?.isEmpty != nil {
        Text(Image(systemName: icon!))
          .font(.headline)
          .foregroundColor(.white)
          .frame(height: 55)
          .frame(maxWidth: .infinity)
          .background(color)
          .cornerRadius(10)
      } else {
        Text(letter ?? "")
          .font(.headline)
          .foregroundColor(.white)
          .frame(height: 55)
          .frame(maxWidth: .infinity)
          .background(color)
          .cornerRadius(10)
      }
    }
  }
}

struct KeyboardButtonView_Preview: PreviewProvider {
  static var previews: some View {
    KeyboardButtonView(letter: "A") { letter in
      print(letter)
    }
      .preferredColorScheme(.dark)
  }
}
