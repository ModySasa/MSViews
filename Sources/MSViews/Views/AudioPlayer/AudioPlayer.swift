//
//  SwiftUIView.swift
//  
//
//  Created by Mohammad on 18/03/2024.
//

import SwiftUI
import AVFoundation
import Foundation

public struct AudioPlayer : View {
    @State private var audioPlayer: AVAudioPlayer?
    @State private var isPlaying = false
    @State private var heights : [Double] = .init(repeating: Double.random(in: 0...40), count: 50)
    private let timer = Timer.publish(every: 0.25, on: .main, in: .common).autoconnect()
    
    private var audioURL: URL? = nil
    
    public init(
        audioURL: URL? = nil
    ) {
        self.audioURL = audioURL
    }
    
    public var body: some View {
        VStack(spacing: 10) {
            if(isPlaying) {
                    HStack(spacing:2) {
                        ForEach(0..<50, id: \.self) { i in
                            Rectangle()
                                .frame(width: 1, height: heights[i] , alignment: .center)
                                .onReceive(timer, perform: { _ in
                                    if(isPlaying) {
                                        heights[i] = Double.random(in: 0...40)
                                    }
                                })
                        }
                    }
                }
            Image(systemName: isPlaying ? "pause.circle" : "play.circle")
                .font(.system(size: 80))
                .onTapGesture {
                    if isPlaying {
                        pausePlayback()
                    } else {
                        playRecording()
                    }
                }
                .foregroundStyle(.black)
        }
    }
    
    private func playRecording() {
        guard let audioURL = audioURL else {
            // Handle the case where there's nothing to play
            print("No URL")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioURL)
            audioPlayer?.play()
            isPlaying = true
        } catch {
            // Handle errors here
            print("Error playing recording: \(error.localizedDescription)")
        }
    }
    
    private func pausePlayback() {
        audioPlayer?.pause()
        isPlaying = false
    }
}

//struct AudioPlayer_Previews: PreviewProvider {
//    static var previews: some View {
//        AudioPlayer(hasOptions:false , hasBars: true) { url in
//            
//        }
//    }
//}
