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
            
            HStack {
                
                Button(action: {
                    count -= 1
                }) {
                    Text("-")
                        .font(.largeTitle)
                        .frame(width: 80, height: 80)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    count += 1
                }) {
                    Text("+")
                        .font(.largeTitle)
                        .frame(width: 80, height: 80)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
            }
            .padding()
            
            Button(action: {
                count = 0
            }) {
                Text("Reset")
                    .font(.title)
                    .padding()
                    .frame(width: 180, height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            .padding(.top, 20)
        }
    }
}


#Preview {
    ContentView()
}
