//
//  ContentView.swift
//  ExampleProgressViewStyle
//
//  Created by Mohsen Khosravinia on 5/31/23.
//

import SwiftUI

struct LinearGradientProgressViewStyle: ProgressViewStyle {
    var colors: [Color]
    var lineWidth: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted = configuration.fractionCompleted ?? 0.0
        
        return GeometryReader { geometry in
            VStack(alignment: .leading, spacing: .zero) {
                configuration
                    .currentValueLabel
                    .offset(x: fractionCompleted * geometry.size.width)

                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(Color.gray.opacity(0.3))
                        .frame(height: lineWidth)
                    
                    LinearGradient(
                        gradient: Gradient(colors: colors),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .frame(width: geometry.size.width * fractionCompleted, height: lineWidth)
                    .cornerRadius(5)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

struct ContentView: View {
    @State private var progress: Double = 0.0
    
    var body: some View {
        VStack {
            ProgressView(value: progress, total: 1.0) {} currentValueLabel: {
                VStack {
                    Text(String(format: "%.0f%%", min(progress, 1) * 100))
                        .font(.caption)
                        .padding(.bottom, 4)
                    
                    Image(systemName: "arrowtriangle.down.fill")
                        .tint(Color.black)
                        .padding(.bottom, 4)
                }
            }
            .progressViewStyle(
                LinearGradientProgressViewStyle(
                    colors: [.red, .blue],
                    lineWidth: 10
                )
            )
            .frame(height: 100)
            
            Button("Increment Progress") {
                withAnimation {
                    progress += 0.1
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
