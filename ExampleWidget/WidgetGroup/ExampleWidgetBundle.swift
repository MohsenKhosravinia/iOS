//
//  WidgetBundle.swift
//  ExampleWidgetExtension
//
//  Created by Mohsen Khosravinia on 12/24/22.
//

import SwiftUI
import WidgetKit

@main
struct ExampleWidgetBundle: WidgetBundle {
    var body: some Widget {
        HelloWidget()
        DateTimeWidget()
    }
}
