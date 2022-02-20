//
//  KeyboardView.swift
//  Wordle
//
//  Created by Forrest Wilson-Jennings on 20/02/22.
//

import SwiftUI

struct KeyboardView: View {
  @EnvironmentObject var vm: WordleViewModel
  
  private var topRow: String = "QWERTYUIOP"
  private var middleRow: String = "ASDFGHJKL"
  private var bottomRow: String = "ZXCVBNM"
  
  private func addCharacterToWord(_ letter: String) {
    if vm.currentGuess.count < 5 {
      vm.currentGuess.append(letter)
    }
  }
  
  var body: some View {
    VStack(spacing: 2) {
      HStack(spacing: 2) {
        ForEach(0 ..< topRow.count) { index in
          KeyboardButtonView(
            letter: topRow[index],
            color: vm.getColorForKeyboardLetter(topRow[index]),
            action: addCharacterToWord
          )
        }
      }
      
      HStack(spacing: 2) {
        ForEach(0 ..< middleRow.count) { index in
          KeyboardButtonView(
            letter: middleRow[index],
            color: vm.getColorForKeyboardLetter(middleRow[index]),
            action: addCharacterToWord
          )
        }
      }
      .padding(.horizontal)
      
      HStack(spacing: 2) {
        KeyboardButtonView(
          letter: "ENTER",
          color: .green
        ) { _ in
          withAnimation {
            vm.checkWord(vm.currentGuess)
          }
        }
          .frame(minWidth: 65)

        ForEach(0 ..< bottomRow.count) { index in
          KeyboardButtonView(
            letter: bottomRow[index],
            color: vm.getColorForKeyboardLetter(bottomRow[index]),
            action: addCharacterToWord
          )
        }
        
        KeyboardButtonView(icon: "xmark.square") { _ in
          vm.backspace()
        }
          .frame(minWidth: 65)
      }
    }
    .padding(.bottom)
  }
}

struct KeyboardView_Preview: PreviewProvider {
  static var previews: some View {
    KeyboardView()
      .preferredColorScheme(.dark)
  }
}
