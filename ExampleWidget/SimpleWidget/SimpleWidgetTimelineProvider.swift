//
//  SimpleWidgetTimelineProvider.swift
//  SimpleWidgetExtension
//
//  Created by Mohsen Khosravinia on 12/12/22.
//

import WidgetKit

struct SimpleWidgetTimelineProvider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleWidgetEntry {
        SimpleWidgetEntry()
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleWidgetEntry) -> Void) {
        completion(SimpleWidgetEntry())
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleWidgetEntry>) -> Void) {
        completion(Timeline(entries: [SimpleWidgetEntry()], policy: .never))
    }
}
