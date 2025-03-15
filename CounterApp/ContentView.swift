//
//  ContentView.swift
//  CounterApp
//
//  Created by Jafar Nasir on 15.03.25.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    
    @State private var count = 0
    @State var player: AVAudioPlayer?
    
    var body: some View {
        
        VStack {
            
            Text("Counter: \(count)")  // Выводим текущее значение
                .font(.largeTitle)
                .padding()
            
            HStack {
                
                Button(action: {
                    count -= 1
                    playSound()
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
                    playSound()
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
                playSound()
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
    
    func playSound() {
            guard let url = Bundle.main.url(forResource: "click", withExtension: "mp3") else { return }

            do {
                player = try AVAudioPlayer(contentsOf: url)
                player?.play()
            } catch {
                print("Error Playing Sound")
            }
        }
}


#Preview {
    ContentView()
}
