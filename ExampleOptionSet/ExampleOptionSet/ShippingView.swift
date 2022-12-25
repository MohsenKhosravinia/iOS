//
//  ContentView.swift
//  ExampleOptionSet
//
//  Created by Mohsen Khosravinia on 12/25/22.
//

import SwiftUI

struct ShippingView: View {
    @ObservedObject var viewModel: ShippingViewModel
    
    init(viewModel: ShippingViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: .zero) {
            Text("Shipping Types")
                .font(.title)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.mint)
            
            List {
                ForEach(viewModel.items, id: \.self) { item in
                    Text("\(item)")
                }
                .padding()
            }
            .font(.body)
        }
    }
}

struct ShippingView_Previews: PreviewProvider {
    static var previews: some View {
        ShippingView(
            viewModel: ShippingViewModel(types: ShippingOptions.all)
        )
    }
}
