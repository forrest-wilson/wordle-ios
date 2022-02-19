//
//  MessageAlert.swift
//  Wordle
//
//  Created by Forrest Wilson-Jennings on 19/02/22.
//

import SwiftUI

struct MessageAlert: View {
  var message: String
  var durationInSeconds: Double? = 3 // Duration in seconds
  var show: Bool
  
  var body: some View {
    if show {
      Text(message)
        .font(.headline)
        .background(.white)
        .foregroundColor(.black)
        .padding()
        .frame(minWidth: 100)
        .frame(height: 60)
        .background(.white)
        .cornerRadius(10)
        .shadow(color: .gray, radius: 100)
    }
  }
}

struct MessageAlert_Preview: PreviewProvider {
  static var previews: some View {
    MessageAlert(message: "Message", show: true)
  }
}
