// Created by brainfck on 9/15/24.

import SwiftUI

struct ContentView: View {
  @State private var isNight = false
  
  let days = ["TUE", "WED", "THU", "FRI", "SAT"]
  let icons = ["cloud.sun.fill", "sun.max.fill", "wind", "sunset.fill", "moon.stars.fill"]

  var body: some View {
    ZStack {
      BackgroundView(isNight: isNight)
      
      VStack {
        CityTextView(cityName: "Cupertino, CA")
        MainWeatherStatusView(imageName: isNight ? "moon.stars.fill" : "cloud.sun.fill", temperature: 25)
        
        HStack(spacing: 20) {
          ForEach(0 ..< 5) { item in
            WeatherDayView(
              dayOfWeek: days[item],
              imageName: icons[item],
              temperature: Int.random(in: 0 ... 30)
            )
          }
        }
        .padding()
        
        Spacer()
        
        Button {
          isNight.toggle()
        } label: {
          WeatherButton(title: "Change Day Time", textColor: .blue, backgroundColor: .white)
        }
        
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
        .symbolRenderingMode(.multicolor  )
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 40, height: 40)
      
      Text("\(temperature)°")
        .font(.system(size: 28, weight: .medium))
        .foregroundStyle(.white)
    }
  }
}

struct BackgroundView: View {
  var isNight: Bool
  
  var body: some View {
    LinearGradient(
      gradient: Gradient(colors: [isNight ? .black : .blue,
                                  isNight ? .gray : Color("lightBlue")]),
      startPoint: .topLeading,
      endPoint: .bottomTrailing
    )
    .ignoresSafeArea()
    
//    ContainerRelativeShape()
//      .fill(isNight ? Color.black.gradient : Color.blue.gradient)
//      .ignoresSafeArea()
  }
}

struct CityTextView: View {
  var cityName: String
  
  var body: some View {
    Text(cityName)
      .font(.system(size: 32, weight: .medium))
      .foregroundStyle(.white)
      .padding()
  }
}

struct MainWeatherStatusView: View {
  var imageName: String
  var temperature: Int
  
  var body: some View {
    VStack(spacing: 8) {
      Image(systemName: imageName)
        .renderingMode(.original)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 180, height: 180)
      
      Text("\(temperature)°")
        .font(.system(size: 70, weight: .medium))
        .foregroundStyle(.white)
    }
    .padding(.bottom, 40)
  }
}

struct WeatherButton: View {
  var title: String
  var textColor: Color
  var backgroundColor: Color
  
  var body: some View {
    Text(title)
      .frame(width: 280, height: 50)
      .background(backgroundColor.gradient)
      .foregroundStyle(textColor)
      .font(.system(size: 20, weight: .bold))
      .cornerRadius(10)
  }
}
