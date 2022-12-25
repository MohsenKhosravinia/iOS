//
//  HelloWidget.swift
//  HelloWidget
//
//  Created by Mohsen Khosravinia on 12/12/22.
//

import WidgetKit
import SwiftUI

struct HelloWidget: Widget {
    let kind = "com.khosravinia.mohsen.hello.widget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: HelloWidgetTimelineProvider()
        ) { _ in
            HelloWidgetEntryView()
        }
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
        .configurationDisplayName("Hello Widget")
        .description("This is a simple widget.")
    }
}
