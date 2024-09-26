//
//  ContentView.swift
//  BarcodeScanner
//
//  Created by Mykhailo Tsuber on 9/22/24.
//

import SwiftUI

struct BarcodeScannerView: View {
    var body: some View {
      NavigationView {
        VStack {
          ScannerView()
            .frame(maxWidth: .infinity, maxHeight: 300)
          
          Spacer().frame(height: 60)
          
          Label("Scanned Barcode:", systemImage: "barcode.viewfinder")
            .font(.title)
          
          Text("Not Yet Scanned")
            .bold()
            .font(.largeTitle)
            .foregroundStyle(.green)
            .padding()
        }
        .navigationTitle("Barcode Scanner")
      }
    }
}

#Preview {
    BarcodeScannerView()
}
