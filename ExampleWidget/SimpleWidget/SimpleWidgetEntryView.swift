//
//  SimpleWidgetView.swift
//  SimpleWidgetExtension
//
//  Created by Mohsen Khosravinia on 12/12/22.
//

import SwiftUI

struct SimpleWidgetEntryView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Hello")
                .foregroundColor(.mint)
                .font(.body)
            
            Text("Mohsen!!!")
                .foregroundColor(.primary)
                .font(.caption)
        }
    }
}

struct SimpleWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleWidgetEntryView()
    }
}
