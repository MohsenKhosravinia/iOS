//
//  ExampleOptionSetApp.swift
//  ExampleOptionSet
//
//  Created by Mohsen Khosravinia on 12/25/22.
//

import SwiftUI

@main
struct ExampleOptionSetApp: App {
    var body: some Scene {
        WindowGroup {
            ShippingView(
                viewModel: ShippingViewModel(types: ShippingOptions.all)
            )
        }
    }
}
