//
//  ContentView.swift
//  Wordle
//
//  Created by Forrest Wilson-Jennings on 17/02/22.
//

import SwiftUI

struct WordleView: View {
  @StateObject private var vm = WordleViewModel()
  private var state = UserDefaultsViewModel()

  var body: some View {
    ZStack {
      VStack {
        ScrollView {
          ZStack {
            VStack {
              ForEach(vm.guesses, id: \.self) { guess in
                HStack {
                  ForEach(0 ..< guess.count, id: \.self) { index in
                    LetterBoxView(text: guess[index].uppercased(), color: vm.getColorForLetter(guess[index], index))
                  }
                }
                .padding(.horizontal)
                .padding(.vertical, 5)
              }
              
              if vm.remainingAttempts != 0 {
                HStack {
                  ForEach(0 ..< 5, id: \.self) { index in
                    LetterBoxView(
                      text: index >= vm.currentGuess.count ? "" : vm.currentGuess[index],
                      borderColor: .gray
                    )
                  }
                }
                .padding(.horizontal)
                .padding(.vertical, 5)
              }
              
              ForEach(0 ..< (vm.remainingAttempts <= 1 ? 0 : vm.remainingAttempts - 1), id: \.self) { int in
                HStack {
                  ForEach(0 ..< 5, id: \.self) { index in
                    LetterBoxView(text: "", borderColor: .gray)
                  }
                }
                .padding(.horizontal)
                .padding(.vertical, 5)
              }
            }.zIndex(0)
            
            MessageAlertView(message: vm.message, show: $vm.showMessageAlert).zIndex(1)
          }
        }
        
        KeyboardView()
      }
      .preferredColorScheme(.dark)
      .environmentObject(vm)
      .preferredColorScheme(.dark)
      
      if vm.gameState == .Won {
        AlertView(
          message: "You won!"
        ) {
          withAnimation {
            vm.pickNewWord()
          }
        }
      }
      
      if vm.gameState == .Lost {
        AlertView(message: "You lost!", icon: "xmark.circle.fill", iconColor: .red) {
          withAnimation {
            vm.pickNewWord()
          }
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    WordleView()
  }
}
