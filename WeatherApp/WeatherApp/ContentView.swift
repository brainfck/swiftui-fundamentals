// Created by brainfck on 9/15/24.

import SwiftUI

struct ContentView: View {
  var body: some View {
    ZStack {
      LinearGradient(
        gradient: Gradient(colors: [Color.blue, Color.white]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
      )
        .edgesIgnoringSafeArea(.all)
      
      VStack {
        Text("Cupertino, CA")
          .font(.system(size: 32, weight: .medium, design: .default))
          .foregroundStyle(.white)
          .padding()
        Spacer()
      }
    }
  }
}

#Preview {
  ContentView()
}
