//
//  AlertView.swift
//  Wordle
//
//  Created by Forrest Wilson-Jennings on 21/02/22.
//

import SwiftUI

struct AlertView: View {
  var message: String
  var word: String?
  var icon: String = "checkmark.circle.fill"
  var iconColor: Color = .green
  var closure: () -> Void
  
  @StateObject private var state = UserDefaultsViewModel()
  
  var body: some View {
    ZStack {
      VStack {
        Image(systemName: icon)
          .resizable()
          .frame(width: 50, height: 50)
          .padding(.top, 10)
          .foregroundColor(iconColor)
        
        Text(message)
          .foregroundColor(.white)
          .font(.title)
          .fontWeight(.bold)
        
        if word != nil {
          Text("The word was:")
            .fontWeight(.light)
            .padding(.bottom, 5)
          
          Text(word!.uppercased())
            .font(.title)
            .fontWeight(.bold)
        }
        
        Divider()
        
        Text("Current score: \(state.currentScore)")
        Text("Highest score: \(state.highestScore)")
        
        Divider()
        
        HStack {
          Button() {
             closure()
          } label: {
            Text("Play Again")
              .frame(maxWidth: .infinity)
              .foregroundColor(.white)
              .padding(.vertical, 10)
          }
        }
        .padding(.bottom, 5)
      }
      .frame(width: UIScreen.main.bounds.width - 50)
      .background(Color(.sRGB, red: 50/255, green: 50/255, blue: 50/255, opacity: 1))
      .cornerRadius(10)
      .clipped()
      .shadow(color: .black, radius: 100)
      .zIndex(1)
      
      Rectangle()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .foregroundColor(.black.opacity(0.5))
        .zIndex(0)
    }
  }
}

struct AlertView_Preview: PreviewProvider {
  static var previews: some View {
    AlertView(
      message: "You won!",
      word: "apple"
    ) {
      print("Hello")
    }
      .preferredColorScheme(.dark)
.previewInterfaceOrientation(.portrait)
  }
}
