//
//  SimpleWidgetView.swift
//  SimpleWidgetExtension
//
//  Created by Mohsen Khosravinia on 12/12/22.
//

import SwiftUI
import WidgetKit

struct SimpleWidgetEntryView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Hello")
                .foregroundColor(.mint)
                .font(.title2)
                .fontWeight(.bold)
            
            Text("Mohsen!!!")
                .foregroundColor(.primary)
                .font(.title2)
        }
    }
}

struct SimpleWidget_Previews: PreviewProvider {
    static var previews: some View {
        SimpleWidgetEntryView()
            .previewContext(
                WidgetPreviewContext(family: .systemSmall)
            )
    }
}
