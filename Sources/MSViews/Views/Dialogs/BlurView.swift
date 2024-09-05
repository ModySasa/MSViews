//
//  BlurVuew.swift
//  VisionDimensions
//
//  Created by Corptia 02 on 11/05/2023.
//

import SwiftUI

public struct BlurView: View {
    public var color = Color.black
    public var opacity = 0.8
    public init(
        color: SwiftUI.Color = Color.black
        , opacity: Double = 0.8
    ) {
        self.color = color
        self.opacity = opacity
    }
    public var body: some View {
        dimView
    }
    
    private var dimView: some View {
        color
            .opacity(opacity)
            .ignoresSafeArea()
        //            .opacity(backgroundOpacity)
    }
}

struct BlurView_Previews: PreviewProvider {
    static var previews: some View {
        BlurView()
    }
}
