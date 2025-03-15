//
//  ContentView.swift
//  CounterApp
//
//  Created by Jafar Nasir on 15.03.25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var count = 0
    
    var body: some View {
            VStack {
                Text("Counter: \(count)")  // Выводим текущее значение
                    .font(.largeTitle)
                    .padding()
            }
        }
}

#Preview {
    ContentView()
}
