//
//  ExploreNewThingsApp.swift
//  ExploreNewThings
//
//  Created by Mohsen Khosravinia on 6/7/23.
//

import SwiftUI
import SwiftData

@main
struct ExploreNewThingsApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Item.self)
    }
}
