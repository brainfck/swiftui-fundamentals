//
//  FrameworkGridViewModel.swift
//  AppleFrameworks
//
//  Created by Mykhailo Tsuber on 9/21/24.
//

import SwiftUI

final class FrameworkGridViewModel: ObservableObject {
  let columns: [GridItem] = [
    GridItem(.flexible()),
    GridItem(.flexible()),
    GridItem(.flexible()),
  ]
}
