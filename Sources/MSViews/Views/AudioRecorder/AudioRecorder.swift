//
//  SwiftUIView.swift
//  
//
//  Created by Corptia 02 on 18/09/2023.
//


import SwiftUI
import AVFoundation
import Foundation

struct AudioRecorder : View {
    @State private var audioRecorder: AVAudioRecorder?
    @State private var audioPlayer: AVAudioPlayer?
    @State private var isRecording = false
    @State private var isPlaying = false
    @State private var audioURL: URL?
    @State private var heights : [Double] = .init(repeating: Double.random(in: 0...40), count: 50)
    
    var hasOptions : Bool = true
    var hasBars : Bool = false
    let timer = Timer.publish(every: 0.25, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing: 10) {
            if(hasBars) {
                if(isRecording) {
                    HStack(spacing:2) {
                        ForEach(0..<50, id: \.self) { i in
                            Rectangle()
                                .frame(width: 1, height: heights[i] , alignment: .center)
                                .onReceive(timer, perform: { _ in
                                    if(isRecording) {
                                        heights[i] = Double.random(in: 0...40)
                                    }
                                })
                        }
                    }
                }
            }
            Image(systemName: isRecording ? "stop.circle" : "mic.circle")
                .font(.system(size: 80))
                .onTapGesture {
                    if isRecording {
                        stopRecording()
                    } else {
                        startRecording()
                    }
                }
                .foregroundStyle(.black)
            if(hasOptions) {
                HStack (spacing: 30) {
                    Image(systemName: "gobackward")
                        .onTapGesture {
                            resetRecording()
                        }
                    Image(systemName: "square.and.arrow.down")
                        .onTapGesture {
                            saveRecording()
                        }
                    Image(systemName: isPlaying ? "pause.circle" : "play.circle")
                        .onTapGesture {
                            if isPlaying {
                                pausePlayback()
                            } else {
                                playRecording()
                            }
                        }
                }
                .font(.system(size: 25))
                .foregroundColor(MSViews.shared.viewsHelper.mainAppColor)
            }
        }
    }
    
    func startRecording() {
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(.record, mode: .default, options: [])
            try audioSession.setActive(true)
            
            let audioSettings: [String: Any] = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 44100,
                AVNumberOfChannelsKey: 2,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            
            let tempAudioURL = FileManager.default.temporaryDirectory.appendingPathComponent("tempRecording.m4a")
            
            audioRecorder = try AVAudioRecorder(url: tempAudioURL, settings: audioSettings)
            audioRecorder?.record()
            isRecording = true
        } catch {
            // Handle errors here
            print("Error starting recording: \(error.localizedDescription)")
        }
    }
    
    func stopRecording() {
        audioRecorder?.stop()
        isRecording = false
        audioURL = audioRecorder?.url
        
        if(!hasOptions) {
            saveRecording()
        }
    }
    
    func resetRecording() {
        if isRecording {
            stopRecording()
        }
        audioURL = nil
        // Delete any temporary audio files if needed
    }
    
    var afterRecorded : (Data , URL)->Void
    
    func saveRecording() {
        guard let audioURL = audioURL else {
            // Handle the case where there's nothing to save
            print("FAILED TO SAVE")
            return
        }
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let destinationURL = documentsDirectory.appendingPathComponent("\(UUID().uuidString)_audio.m4a")
        
        do {
            try FileManager.default.moveItem(at: audioURL, to: destinationURL)
            do {
                let audioData = try Data(contentsOf: destinationURL)
                afterRecorded(audioData , destinationURL)
            } catch {
                print("Error converting audio file to Data: \(error.localizedDescription)")
            }
            
            // The recording is now saved to the destinationURL
        } catch {
            // Handle errors here
            print("Error saving recording: \(error.localizedDescription)")
        }
    }
    
    func playRecording() {
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
    
    func pausePlayback() {
        audioPlayer?.pause()
        isPlaying = false
    }
}

struct AudioRecorder_Previews: PreviewProvider {
    static var previews: some View {
        AudioRecorder(hasOptions:false , hasBars: true) { data , url in
            
        }
    }
}
