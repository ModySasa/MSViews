//
//  SwiftUIView.swift
//  
//
//  Created by Corptia 02 on 18/09/2023.
//

import SwiftUI

public struct AudioRecorderDialog: View {
    @Binding public var showDialog: Bool
    public var dismissByClick : Bool = true
    public var hasOptions : Bool = true
    public var hasBars : Bool = true
    public var isPlayingBack : Bool = false
    public var audioURL: URL? = nil
    public var afterRecorded : (Data , URL)->Void
    
    public init(
        showDialog: Binding<Bool>
        , dismissByClick: Bool = true
        , hasOptions : Bool = true
        , hasBars : Bool = true
        , isPlayingBack : Bool = false
        , audioURL: URL? = nil
        , afterRecorded: @escaping (Data , URL) -> Void
    ) {
        self._showDialog = showDialog
        self.dismissByClick = dismissByClick
        self.afterRecorded = afterRecorded
        self.hasOptions = hasOptions
        self.hasBars = hasBars
        self.isPlayingBack = isPlayingBack
        self.audioURL = audioURL
    }
    
    public var body: some View {
        CommonNoButtonsDialog(dismissByClick: dismissByClick , showDialog: $showDialog) {
            
        } content :{
            if(isPlayingBack && audioURL != nil) {
                AudioPlayer(audioURL: audioURL)
            } else {
                AudioRecorder(hasOptions: hasOptions , hasBars: hasBars , afterRecorded:afterRecorded)
            }
        }
    }
}

struct AudioRecorderDialog_Previews: PreviewProvider {
    static var previews: some View {
        AudioRecorderDialog(showDialog: .constant(true)) { data , url in
            
        }
    }
}
