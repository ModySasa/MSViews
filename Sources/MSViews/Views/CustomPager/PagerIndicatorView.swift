//
//  SwiftUIView.swift
//  
//
//  Created by Corptia 02 on 21/05/2023.
//

import SwiftUI

public struct PagerIndicatorView<Background:View>: View {
    @Binding var selection : Int
    var tabs : [PagerItem]
    var height = 10.0
    var selectedWidth = 30.0
    var unSelectedWidth = 10.0
    var marginBottom = 10.0
    var selectedColor = Color.red
    var unSelectedColor = Color.red.opacity(0.6)
    var autoMove = true
    var background : Background
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    public init(
        selection : Binding<Int>
        , tabs : [PagerItem]
        ,height : CGFloat = 10.0
        ,selectedWidth : CGFloat = 30.0
        ,unSelectedWidth : CGFloat = 10.0
        ,marginBottom : CGFloat = 10.0
        ,selectedColor : Color = Color.red
        ,unSelectedColor : Color = Color.red.opacity(0.6)
        ,autoMove : Bool = false
        ,@ViewBuilder background : ()->Background
        ,duration : Int = 1
    ) {
        self.tabs = tabs
        self._selection = selection
        self.marginBottom = marginBottom
        self.height = height
        self.selectedWidth = selectedWidth
        self.unSelectedWidth = unSelectedWidth
        self.selectedColor = selectedColor
        self.unSelectedColor = unSelectedColor
        self.autoMove = autoMove
        self.background = background()
        self.timer = Timer.publish(every: TimeInterval(duration), on: .main, in: .common).autoconnect()
    }
    
    public var body: some View {
        HStack {
            ForEach(tabs ,id: \.self) { tab in
                let index = tab.index
                let isSelected = index == selection
                RoundedRectangle(cornerRadius: height)
                    .fill(isSelected ? selectedColor : unSelectedColor)
                    .frame(width: isSelected ? selectedWidth : unSelectedWidth, height: height)
                    .onTapGesture {
                        switchToTab(index)
                    }
            }
        }
        .onReceive(timer, perform: { _ in
            if(autoMove){
                if(selection < (tabs.count - 1)) {
                    switchToTab(selection + 1)
                } else {
                    switchToTab(0)
                }
            }
        })
        .frame(maxWidth: .infinity)
        .padding(.bottom, marginBottom)
        .background(
            ZStack {
                Color.clear
                background
            }
                .edgesIgnoringSafeArea(.bottom)
        )
    }
    
    func switchToTab(_ index: Int) {
        withAnimation(.easeOut) {
            selection = index
        }
    }
    
}

fileprivate struct IndicatorHelper : View{
    @State var selection = 0
    @State var count = 5
    
    var body: some View {
        PagerIndicatorView(
            selection: $selection
            , tabs:
                    .init(arrayLiteral:
                            .init(iconName: "", title: "", index: 0 , description: "" , object: "" as AnyObject)
                          ,.init(iconName: "", title: "", index: 1 , description: "" , object: "" as AnyObject)
                    )
            
            , autoMove: true
            , background: {
                Color.green
            }
            ,duration: 1
        )
    }
}

struct PagerIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        IndicatorHelper()
    }
}
