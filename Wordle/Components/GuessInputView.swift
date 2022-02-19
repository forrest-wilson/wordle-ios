//
//  GuessInput.swift
//  Wordle
//
//  Created by Forrest Wilson-Jennings on 19/02/22.
//

import SwiftUI
import Combine

struct GuessInputView: View {
  @EnvironmentObject var vm: WordleViewModel
  
  private var frameHeight: CGFloat = 50
  private var cornerRadius: CGFloat = 10
  
  var body: some View {
    VStack {
      Text("\(vm.remainingAttempts) attempts remaining")

      HStack {
        TextField("Type guess here", text: $vm.currentGuess)
          .font(.headline)
          .frame(height: frameHeight)
          .background(Color(red: 60/255, green: 60/255, blue: 60/255))
          .cornerRadius(cornerRadius)
          .multilineTextAlignment(.center)
          .disableAutocorrection(true)
          .onReceive(Just(vm.currentGuess)) { value in
            if value.count > 5 {
              vm.currentGuess.removeLast()
            }
          }

        Button("Check") {
          withAnimation {
            vm.checkWord(vm.currentGuess)
            vm.currentGuess = ""
          }
        }
        .font(.headline)
        .foregroundColor(.white)
        .frame(height: frameHeight)
        .padding(.horizontal)
        .background(.green)
        .cornerRadius(cornerRadius)
      }
      .padding([.horizontal, .bottom])
    }
  }
}

struct GuessInput_Preview: PreviewProvider {
  static var previews: some View {
    GuessInputView()
  }
}
