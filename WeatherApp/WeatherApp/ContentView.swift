// Created by brainfck on 9/15/24.

import SwiftUI

struct ContentView: View {
  let days = ["TUE", "WED", "THU", "FRI", "SAT"]
  let icons = ["cloud.sun.fill", "sun.max.fill", "wind", "sunset.fill", "moon.stars.fill"]

  var body: some View {
    ZStack {
      LinearGradient(
        gradient: Gradient(colors: [Color.blue, Color("lightBlue")]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
      )
        .edgesIgnoringSafeArea(.all)
      
      VStack {
        Text("Cupertino, CA")
          .font(.system(size: 32, weight: .medium))
          .foregroundStyle(.white)
          .padding()
        
        VStack(spacing: 8) {
          Image(systemName: "cloud.sun.fill")
            .renderingMode(.original)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 180, height: 180)
          
          Text("25°")
            .font(.system(size: 70, weight: .medium))
            .foregroundStyle(.white)
        }
        .padding(.bottom, 40)
        
        HStack(spacing: 20) {
          ForEach(0..<5) { item in
            WeatherDayView(
              dayOfWeek: days[item],
              imageName: icons[item],
              temperature: Int.random(in: 0...30)
            )
          }
        }
        .padding()
        
        Spacer()
      }
    }
  }
}

#Preview {
  ContentView()
}

struct WeatherDayView: View {
  var dayOfWeek: String
  var imageName: String
  var temperature: Int
  
  var body: some View {
    VStack {
      Text(dayOfWeek)
        .font(.system(size: 16, weight: .medium))
        .foregroundStyle(.white)
      
      Image(systemName: imageName)
        .renderingMode(.original)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 40, height: 40)
      
      Text("\(temperature)°")
        .font(.system(size: 28, weight: .medium))
        .foregroundStyle(.white)
    }
  }
}
