//
//  SwiftUIView.swift
//  
//
//  Created by Corptia 02 on 28/05/2023.
//

import SwiftUI

public struct Switch: View {
    @Binding var isOn : Bool
    var isOnBackColor : Color = .yellow
    var isOffBackColor : Color = .gray
    var isOnColor : Color = .red
    var isOffColor : Color = .gray
    @State var cornerRadius : CGFloat = 25
    var width : CGFloat = 100
    var height : CGFloat = 50
    var irisWidth : CGFloat = 25
    var irisHeight : CGFloat = 20
    var irisRadius : CGFloat = 2
    var irisPadding : CGFloat = 5
    var irisType : Iris_type = .circle
    
    public init(
        isOn: Binding<Bool>
        , isOnBackColor: Color = .yellow
        , isOffBackColor: Color = .gray
        , isOnColor: Color = .red
        , isOffColor: Color = .gray
        , cornerRadius: CGFloat =  25
        , width: CGFloat =  100
        , height: CGFloat =  50
        , irisWidth: CGFloat =  25
        , irisHeight: CGFloat =  20
        , irisRadius: CGFloat =  2
        , irisPadding: CGFloat =  5
        , irisType: Iris_type = .circle
    ) {
        self._isOn = isOn
        self.isOnBackColor = isOnBackColor
        self.isOffBackColor = isOffBackColor
        self.isOnColor = isOnColor
        self.isOffColor = isOffColor
        self.cornerRadius = cornerRadius
        self.width = width
        self.height = height
        self.irisWidth = irisWidth
        self.irisHeight = irisHeight
        self.irisRadius = irisRadius
        self.irisPadding = irisPadding
        self.irisType = irisType
    }
    
    public enum Iris_type {
        case circle
        case rectangle
        case roundedRectangle
    }
    
    public var body: some View {
        mySwitch
    }
    
    var mySwitch : some View {
        ZStack(alignment: isOn ? .trailing : .leading){
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(
                    isOn ? isOnBackColor : isOffBackColor
                )
                .frame(width: width, height: height)
            getIris()
                .padding(.horizontal , irisPadding)
        }
        .onAppear {
            if (irisType == .rectangle) {
                cornerRadius = 0
            } else if (irisType == .roundedRectangle) {
                cornerRadius = irisRadius
            }
        }
        .onTapGesture {
            withAnimation {
                isOn.toggle()
            }
        }
    }
    
    @ViewBuilder func getIris() -> some View {
        switch irisType {
        case .circle :
            Circle()
                .fill(isOn ? isOnColor : isOffColor)
                .frame(maxWidth: irisWidth)
        case .rectangle:
            Rectangle()
                .fill(isOn ? isOnColor : isOffColor)
                .frame(width: irisWidth , height: irisHeight)
        case .roundedRectangle:
            RoundedRectangle(cornerRadius: irisRadius)
                .fill(isOn ? isOnColor : isOffColor)
                .frame(width: irisWidth , height: irisHeight)
        }
    }
    
}

fileprivate struct SwitchPreviewHelper : View {
    @State var isOn : Bool = false
    let isOnBackColor : Color = .yellow
    let isOffBackColor : Color = .gray
    let isOnColor : Color = .red
    let isOffColor : Color = .gray
    let cornerRadius : CGFloat = 25
    let width : CGFloat = 100
    let height : CGFloat = 50
    let irisWidth : CGFloat = 30
    let irisHeight : CGFloat = 30
    let irisRadius : CGFloat = 20
    let irisPadding : CGFloat = 10
    let irisType : Switch.Iris_type = .rectangle
    
    
    var body: some View {
        Switch(
            isOn: $isOn ,
            isOnBackColor: isOnBackColor,
            isOffBackColor: isOffBackColor,
            isOnColor: isOnColor,
            isOffColor: isOffColor,
            cornerRadius: cornerRadius,
            width: width,
            height: height,
            irisWidth: irisWidth ,
            irisHeight: irisHeight,
            irisRadius: irisRadius,
            irisPadding: irisPadding,
            irisType :irisType
        )
    }
}

fileprivate struct Switch_Previews: PreviewProvider {
    static var previews: some View {
        SwitchPreviewHelper()
    }
}
