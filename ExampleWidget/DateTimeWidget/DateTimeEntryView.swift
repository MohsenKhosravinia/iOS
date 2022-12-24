//
//  DateTimeEntryView.swift
//  ExampleWidgetExtension
//
//  Created by Mohsen Khosravinia on 12/24/22.
//

import SwiftUI
import WidgetKit

struct DateTimeEntryView: View {
    let entry: DateTimeWidgetEntry
    
    var body: some View {
        ZStack {
            VStack(spacing: 5) {
                Text(getMonth())
                    .bold()
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .frame(maxWidth: .infinity, maxHeight: 30)
                    .background(Rectangle().fill(Color.red))
                
                Text(getDay())
                
                Text(getDate())
                    .font(.largeTitle)
                
                Text(getTime())
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .shadow(color: .gray, radius: 5, x: 5, y: 5)
            )
            .padding(20)
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    private func getDay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        return dateFormatter.string(from: entry.date)
    }
    
    private func getDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: entry.date)
    }
    
    private func getMonth() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        return dateFormatter.string(from: entry.date)
    }
    
    private func getTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        return dateFormatter.string(from: entry.date)
    }
    
    
}

struct DateTimeEntryView_Previews: PreviewProvider {
    static var previews: some View {
        DateTimeEntryView(
            entry: DateTimeWidgetEntry(date: Date())
        )
        .previewContext(
            WidgetPreviewContext(family: .systemSmall)
        )
    }
}
