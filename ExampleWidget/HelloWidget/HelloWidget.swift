//
//  HelloWidget.swift
//  HelloWidget
//
//  Created by Mohsen Khosravinia on 12/12/22.
//

import WidgetKit
import SwiftUI

@main
struct HelloWidget: Widget {
    let kind = "com.khosravinia.mohsen.simple.widget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: HelloWidgetTimelineProvider()
        ) { _ in
            HelloWidgetEntryView()
        }
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
        .configurationDisplayName("Simple Widget")
        .description("This is an example widget.")
        
    }
}
