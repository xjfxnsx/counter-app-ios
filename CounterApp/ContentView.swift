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
                    soundManager.playSound()
                }) {
                    Text("-")
                        .font(.largeTitle)
                        .frame(width: 80, height: 80)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .scaleEffect(buttonScale)
                        .animation(.spring(response: 0.3, dampingFraction: 0.5), value: buttonScale)
                }

                Button(action: {
                    count += 1
                    animateButton()
                    soundManager.playSound()
                }) {
                    Text("+")
                        .font(.largeTitle)
                        .frame(width: 80, height: 80)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .scaleEffect(buttonScale)
                        .animation(.spring(response: 0.3, dampingFraction: 0.5), value: buttonScale)
                }
            }
            .padding()

            Button(action: {
                count = 0
                animateButton()
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
}
