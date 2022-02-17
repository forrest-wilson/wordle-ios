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
  
  @State var letters: [String] = [
    "",
    "",
    "",
    "",
    ""
  ]
  
  private var combineLetters: String {
    return letters.reduce("") { result, element in
      return result + element
    }
  }

  var body: some View {
    VStack {
      Text(vm.randomWord ?? "")

      HStack {
        ForEach(0 ..< letters.count, id: \.self) { index in
          TextField("", text: $letters[index])
            .font(.headline)
            .frame(height: 55)
            .background(Color(red: 60/255, green: 60/255, blue: 60/255))
            .cornerRadius(10)
            .multilineTextAlignment(.center)
            .onReceive(Just(letters[index])) { inputValue in
              if inputValue.count > 1 {
                letters[index].removeLast()
              }
            }
        }
      }
      
      Button("Check Answer") {
        let isCorrect = vm.isWordCorrect(combineLetters)
        print(isCorrect)
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
