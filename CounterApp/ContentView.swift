//
//  ContentView.swift
//  CounterApp
//
//  Created by Jafar Nasir on 15.03.25.
//

import SwiftUI
import AVFoundation

class SoundManager {
    var player: AVAudioPlayer?

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


struct ContentView: View {
    @State private var count = 0
    @State private var buttonScale: CGFloat = 1.0
    @State private var buttonColor: Color = Color.gray
    let soundManager = SoundManager()

    var body: some View {
        VStack {
            Text("Counter: \(count)")
                .font(.largeTitle)
                .padding()

            HStack {
                Button(action: {
                    count -= 1
                    animateButton()
                    changeColor()
                    soundManager.playSound()
                }) {
                    Text("-")
                        .font(.largeTitle)
                        .frame(width: 80, height: 80)
                        .background(buttonColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .scaleEffect(buttonScale)
                        .animation(.spring(response: 0.3, dampingFraction: 0.5), value: buttonScale)
                        .animation(.easeInOut(duration: 0.2), value: buttonColor)
                }

                Button(action: {
                    count += 1
                    animateButton()
                    changeColor()
                    soundManager.playSound()
                }) {
                    Text("+")
                        .font(.largeTitle)
                        .frame(width: 80, height: 80)
                        .background(buttonColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .scaleEffect(buttonScale)
                        .animation(.spring(response: 0.3, dampingFraction: 0.5), value: buttonScale)
                        .animation(.easeInOut(duration: 0.2), value: buttonColor)
                }
            }
            .padding()

            Button(action: {
                count = 0
                animateButton()
                changeColor()
                soundManager.playSound()
            }) {
                Text("Reset")
                    .font(.title)
                    .padding()
                    .frame(width: 180, height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .scaleEffect(buttonScale)
                    .animation(.spring(response: 0.3, dampingFraction: 0.5), value: buttonScale)
                    .animation(.easeInOut(duration: 0.2), value: buttonColor)
            }
            .padding(.top, 20)
        }
    }

    func animateButton() {
        buttonScale = 0.8
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            buttonScale = 1.0
        }

    }
    
    func changeColor() {
        let colors: [Color] = [.red, .blue, .green, .yellow, .orange, .purple]
        buttonColor = colors.randomElement() ?? .gray
        }
}
