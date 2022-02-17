//
//  ContentView.swift
//  Wordle
//
//  Created by Forrest Wilson-Jennings on 17/02/22.
//

import SwiftUI
import Combine

struct ContentView: View {
  @StateObject private var vm = WordleViewModel()
  
  @State private var currentGuess: String = ""
  
  private func isGuessValid(_ word: String) -> Bool {
    return word.count == 4
  }

  var body: some View {
    VStack {
      ScrollView {
        VStack {
          ForEach(vm.guesses, id: \.self) { guess in
            HStack {
              ForEach(0 ..< guess.count, id: \.self) { index in
                LetterBox(text: guess[index], color: vm.getColorForLetter(guess[index], index))
              }
            }
            .padding()
          }
        }
      }
      
      Text("\(vm.remainingAttempts) attempts remaining")

      HStack {
        TextField("Type your 5 letter guess here", text: $currentGuess)
          .font(.headline)
          .frame(height: 55)
          .frame(maxWidth: .infinity)
          .background(Color(red: 60/255, green: 60/255, blue: 60/255))
          .cornerRadius(10)
          .padding(.horizontal)
          .multilineTextAlignment(.center)
          .onReceive(Just(currentGuess)) { value in
            if value.count > 5 {
              currentGuess.removeLast()
            } else {
              currentGuess = currentGuess.uppercased()
            }
          }
      }
      
      Button("Check Answer") {
        vm.checkWord(currentGuess)
        currentGuess = ""
      }
      .font(.headline)
      .foregroundColor(.white)
      .frame(height: 55)
      .frame(maxWidth: .infinity)
      .background(.teal)
      .cornerRadius(10)
      .padding(.horizontal)
      .padding(.bottom, 10)
      .disabled(isGuessValid(currentGuess))
    }.preferredColorScheme(.dark)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
