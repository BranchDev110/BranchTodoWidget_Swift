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

struct ContentView: View {
    @State private var thefruit = ""
    @AppStorage("fruit") var fruit = ""
    
    @StateObject private var simulation = Simulation()
    
    var body: some View {
        VStack {
            TextField("Enter fruit", text: $thefruit).multilineTextAlignment(.center).frame(maxWidth: 200)
            Button("Save fruit") {
                fruit = simulation.step.formatted();
            }
            Text("Saved fruit: \(fruit)")
            
            Text("Running \(simulation.step + 1) / \(simulation.nsteps)")
            
            Button("Run simulation") {
                Task {
                    await simulation.run()
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
