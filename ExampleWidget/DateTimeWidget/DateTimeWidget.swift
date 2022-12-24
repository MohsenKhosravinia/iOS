//
//  DateTimeWidget.swift
//  ExampleWidgetExtension
//
//  Created by Mohsen Khosravinia on 12/24/22.
//

import SwiftUI
import WidgetKit

struct DateTimeWidget: Widget {
    let kind = "com.khosravinia.datetime.widget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: DateTimeTimelineProvider()
        ) { entry in
            DateTimeEntryView(entry: entry)
        }
        .supportedFamilies([.systemSmall, .systemMedium])
        .configurationDisplayName("Date Time Widget")
        .description("This widget shows date and time")
    }
}
