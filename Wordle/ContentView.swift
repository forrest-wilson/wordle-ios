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

  var body: some View {
    VStack {
      ScrollView {
        ZStack {
          VStack {
            ForEach(vm.guesses, id: \.self) { guess in
              HStack {
                ForEach(0 ..< guess.count, id: \.self) { index in
                  LetterBox(text: guess[index], color: vm.getColorForLetter(guess[index], index))
                }
              }
              .padding(.horizontal)
              .padding(.vertical, 5)
            }
            
            ForEach(0 ..< vm.remainingAttempts, id: \.self) { int in
              HStack {
                ForEach(0 ..< 5, id: \.self) { index in
                  LetterBox(text: "", borderColor: .gray)
                }
              }
              .padding(.horizontal)
              .padding(.vertical, 5)
            }
          }.zIndex(0)
          
          MessageAlert(message: vm.message, show: $vm.showMessageAlert).zIndex(1)
        }
      }
      
      Text("\(vm.remainingAttempts) attempts remaining")
      
      HStack {
        TextField("Type guess here", text: $currentGuess)
          .font(.headline)
          .frame(height: 55)
          .frame(maxWidth: .infinity)
          .background(Color(red: 60/255, green: 60/255, blue: 60/255))
          .cornerRadius(10)
          .multilineTextAlignment(.center)
          .onReceive(Just(currentGuess)) { value in
            if value.count > 5 {
              currentGuess.removeLast()
            } else {
              currentGuess = currentGuess.uppercased()
            }
          }
        
        Button("Check") {
          withAnimation {
            vm.checkWord(currentGuess)
            currentGuess = ""
          }
        }
        .font(.headline)
        .foregroundColor(.white)
        .frame(height: 55)
        .padding(.horizontal)
        .background(.green)
        .cornerRadius(10)
      }
      .padding([.horizontal, .bottom])
    }
    .preferredColorScheme(.dark)
    .alert("You won!", isPresented: .constant(vm.gameState == .Won)) {
      Button("Play again") {
        vm.pickNewWord()
      }
    } message: {
      Text("You correctly guessed the word!")
    }
    .alert("You lost!", isPresented: .constant(vm.gameState == .Lost)) {
      Button("Play again") {
        vm.pickNewWord()
      }
    } message: {
      Text("The word was '\(vm.randomWord?.uppercased() ?? "")'")
    }
    .onAppear {
      vm.pickNewWord()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
