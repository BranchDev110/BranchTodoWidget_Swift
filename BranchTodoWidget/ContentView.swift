//
//  ContentView.swift
//  BranchTodoWidget
//
//  Created by mac on 2/29/24.
//

import SwiftUI
import Accelerate

class Simulation: ObservableObject {
    @Published var step = 0
    let nsteps = 10
    
    func run() async {
        for n in 0..<nsteps {
            await MainActor.run {
                self.step = n
            }
            print("Running \(n) / \(nsteps)")
            sleep(2)
        }
    }
}

struct RoundedButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.black)
            .padding()
            .background(Color.yellow.cornerRadius(12))
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

struct ContentView: View {
    @State private var blurRadius: CGFloat = 0.0
    @State private var thefruit = ""
    @AppStorage("fruit") var fruit = ""
    
    @StateObject private var simulation = Simulation()
    
    @Environment(\.displayScale) var displayScale
    
    var body: some View {
        VStack {
            TextField("Enter fruit", text: $thefruit).multilineTextAlignment(.center).frame(maxWidth: 200)
            Button("Save fruit") {
                fruit = simulation.step.formatted();
            }
            Text("Saved fruit: \(fruit)").blur(radius: blurRadius)
            
            Text("Running \(simulation.step + 1) / \(simulation.nsteps)")
            
            Button("Run simulation") {
                Task {
                    await simulation.run()
                }
            }
            
            Slider(value: $blurRadius, in: 0...20, minimumValueLabel: Text("0"), maximumValueLabel: Text("20")) {
                Text("Blur radius")
            }
            
            Button("Rounded Style") {}.buttonStyle(RoundedButtonStyle())
            
            Button(" crosshair ") {}.onHover(perform: {hovering in hovering ? NSCursor.crosshair.push() : NSCursor.pop()})
            
            Text("Display Scale\(displayScale)")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
