//
//  MessageAlert.swift
//  Wordle
//
//  Created by Forrest Wilson-Jennings on 19/02/22.
//

import SwiftUI

struct MessageAlert: View {
  @StateObject var vm = WordleViewModel()
  
  var message: String

  @Binding var show: Bool
  
  var body: some View {
    if show {
      Text(message)
        .font(.headline)
        .foregroundColor(.black)
        .padding()
        .frame(minWidth: 100)
        .frame(height: 60)
        .background(.white)
        .cornerRadius(10)
        .shadow(color: .gray, radius: 100)
        .onAppear {
          DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            withAnimation {
              self.show = false
            }
          }
        }
    }
  }
}

struct MessageAlert_Preview: PreviewProvider {
  static var previews: some View {
    MessageAlert(message: "Message", show: .constant(true))
  }
}
