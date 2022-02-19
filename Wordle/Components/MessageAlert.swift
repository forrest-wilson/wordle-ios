//
//  MessageAlert.swift
//  Wordle
//
//  Created by Forrest Wilson-Jennings on 19/02/22.
//

import SwiftUI

struct MessageAlert: View {
  var message: String

  @Binding var show: Bool
  
  var body: some View {
    if show {
      Text(message)
        .font(.headline)
        .foregroundColor(.black)
        .padding(.horizontal)
        .frame(minWidth: 100)
        .frame(height: 45)
        .background(.white)
        .cornerRadius(10)
        .shadow(color: .gray, radius: 100)
        .onAppear {
          DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1250)) {
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
    MessageAlert(message: "This is a message", show: .constant(true))
  }
}
