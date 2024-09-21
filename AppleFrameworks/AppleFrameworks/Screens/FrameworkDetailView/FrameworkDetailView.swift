//
//  FrameworkDetailView.swift
//  AppleFrameworks
//
//  Created by Mykhailo Tsuber on 9/21/24.
//

import SwiftUI

struct FrameworkDetailView: View {
  var framework: Framework

  @State private var isShowingSafariView = false
  
  var body: some View {
    VStack {
      FrameworkTitleView(framework: framework)
      
      Text(framework.description)
        .font(.body)
        .padding()
      
      Spacer()
      
      Button {
        isShowingSafariView = true
      } label: {
//        AFButton(title: "Learn More")
        Label("Learn More", systemImage: "book.fill")
      }
      .buttonStyle(.bordered)
      .controlSize(.large)
      .tint(.red)
    }
    .fullScreenCover(isPresented: $isShowingSafariView) {
      SafariView(url: URL(string: framework.urlString) ?? URL(string: "https://apple.com")!)
    }
  }
}

#Preview {
  FrameworkDetailView(framework: MockData.sampleFramework)
}
