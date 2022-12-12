//
//  ContentView.swift
//  3DButton
//
//  Created by Mohsen Khosravinia on 10/16/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        CustomButton(color: .cyan)
            .padding(.horizontal, 50)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CustomButton: View {
    @State private var backgroundColor: Color
    @State private var isPressed = false
    private let dept: CGFloat = 12
    private let deptOpacity: CGFloat = 0.7
    private let height: CGFloat = 50
    private let cornerRadius: CGFloat = 12
    
    init(color: Color) {
        backgroundColor = color
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(backgroundColor.opacity(deptOpacity))
                .frame(width: .infinity, height: height - 10)
                .offset(y: dept)
            
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(backgroundColor)
                .frame(width: .infinity, height: height)
                .offset(y: isPressed ? dept : .zero)
            
            Text("BUTTON")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.white)
                .offset(y: isPressed ? dept : .zero)
        }
        .frame(width: .infinity, height: height)
        .onTapGesture {
            withAnimation(.easeOut(duration: 0.2)) {
                isPressed.toggle()
            }
        }
        .onLongPressGesture(minimumDuration: .infinity) {
        } onPressingChanged: { isPressed in
            withAnimation(.easeOut(duration: 0.2)) {
                self.isPressed = isPressed
            }
        }
    }
}
