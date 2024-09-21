//
//  FrameworkGridViewModel.swift
//  AppleFrameworks
//
//  Created by Mykhailo Tsuber on 9/21/24.
//

import SwiftUI

final class FrameworkGridViewModel: ObservableObject {
  var selectedFramework: Framework? {
    didSet { isShowingDetailView = true }
  }

  @Published var isShowingDetailView = false
  
  let columns: [GridItem] = [
    GridItem(.flexible()),
    GridItem(.flexible()),
    GridItem(.flexible()),
  ]
}
