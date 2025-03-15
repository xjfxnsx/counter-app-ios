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
    @State private var count: Int = loadCount()
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
                    saveCount()
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
                        .animation(.easeInOut(duration: 0.2), value: buttonColor)
                }

                Button(action: {
                    count += 1
                    saveCount()
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
                        .animation(.easeInOut(duration: 0.2), value: buttonColor)
                }
            }
            .padding()

            Button(action: {
                count = 0
                saveCount()
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
    
    
    func saveCount() {
        let fileURL = ContentView.getFilePath()
            do {
                let data = try JSONEncoder().encode(count)  // Кодируем число в JSON
                try data.write(to: fileURL)
            } catch {
                print("Ошибка сохранения: \(error)")
            }
        }

        // Функция загрузки из файла
        static func loadCount() -> Int {
            let fileURL = getFilePath()
            do {
                let data = try Data(contentsOf: fileURL)
                return try JSONDecoder().decode(Int.self, from: data)  // Декодируем JSON в Int
            } catch {
                print("Ошибка загрузки: \(error)")
                return 0  // Если ошибка — возвращаем 0
            }
        }

        // Получаем путь к файлу
        static func getFilePath() -> URL {
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            return documentDirectory.appendingPathComponent("count.json")
        }
}
