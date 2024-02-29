//
//  ContentView.swift
//  BranchTodoWidget
//
//  Created by mac on 2/29/24.
//

import SwiftUI
import Accelerate

struct ContentView: View {
    @State private var thefruit = ""
    @AppStorage("fruit") var fruit = ""
    
    var body: some View {
        let x = [2,-3];
        VStack {
            TextField("Enter fruit", text: $thefruit).multilineTextAlignment(.center).frame(maxWidth: 200)
            Button("Save fruit") {
                fruit = thefruit;
            }
            Text("Saved fruit: \(fruit)")
        }
        .padding()
    }
}

struct Content∑View_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
