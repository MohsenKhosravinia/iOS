//
//  DateTimeTimelineProvider.swift
//  ExampleWidgetExtension
//
//  Created by Mohsen Khosravinia on 12/24/22.
//

import WidgetKit

struct DateTimeTimelineProvider: TimelineProvider {
    typealias Entry = DateTimeWidgetEntry
    
    func placeholder(in context: Context) -> DateTimeWidgetEntry {
        DateTimeWidgetEntry(date: Date())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (DateTimeWidgetEntry) -> Void) {
        completion(DateTimeWidgetEntry(date: Date()))
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<DateTimeWidgetEntry>) -> Void) {
        var entries = [DateTimeWidgetEntry]()
        let currentDate = Date() 
        
        for minuteOffset in 1...10 {
            let entryDate = Calendar.current.date(byAdding: .minute, value: minuteOffset, to: currentDate)!
            let entry = DateTimeWidgetEntry(date: entryDate)
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}
