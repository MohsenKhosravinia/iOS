import SwiftUI

struct ContentView: View {
    var body: some View {
        Canvas { context, size in
            context.stroke(Path { path in
                // Starting point at the top-left corner of the letter M
                path.move(to: CGPoint(x: size.width * 0.1, y: size.height * 0.2))
                // Draw the left diagonal line
                path.addLine(to: CGPoint(x: size.width * 0.3, y: size.height * 0.8))
                // Draw the center "V" shape
                path.addLine(to: CGPoint(x: size.width * 0.5, y: size.height * 0.5))
                path.addLine(to: CGPoint(x: size.width * 0.7, y: size.height * 0.8))
                // Draw the right diagonal line
                path.addLine(to: CGPoint(x: size.width * 0.9, y: size.height * 0.2))
            }, with: .color(.blue), lineWidth: 5)
        }
        .frame(width: 300, height: 300)
        .border(Color.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
