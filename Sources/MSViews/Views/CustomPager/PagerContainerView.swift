//
//  SwiftUIView.swift
//  
//
//  Created by Corptia 02 on 21/05/2023.
//

import SwiftUI

public struct PagerContainerView<Content:View , Background:View>: View {
    @Binding var selection : Int
    @State var tabs : [PagerItem] = .init()
    @Binding var hasIndicator : Bool
    let content : Content
    let background : Background

    let unSelectedColor : Color
    let selectedColor : Color
    let selectedWidth : CGFloat
    let marginBottom : CGFloat
    let unSelectedWidth : CGFloat
    let height : CGFloat
    
    public init(
        selection :Binding<Int>
        , hasIndicator : Binding<Bool>
        , selectedColor: Color = .green
        , unSelectedColor: Color = .blue
        , marginBottom: CGFloat = 10
        , selectedWidth: CGFloat = 10
        , unSelectedWidth: CGFloat = 10
        , height: CGFloat = 20
        , @ViewBuilder content: ()->Content
        , @ViewBuilder background: ()-> Background
    ) {
        self._selection = selection
        self._hasIndicator = hasIndicator
        self.content = content()
        self.background = background()
        self.selectedColor = selectedColor
        self.unSelectedColor = unSelectedColor
        self.marginBottom = marginBottom
        self.selectedWidth = selectedWidth
        self.unSelectedWidth = unSelectedWidth
        self.height = height
    }
    
    @State var offsetVal : CGFloat = 0
    
    public var body: some View {
        ZStack {
            content
                .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing)))
                .offset(x:offsetVal)
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            if(msViews.langMethods.isArabic())  {
                                offsetVal = -value.translation.width
                            } else {
                                offsetVal = value.translation.width
                            }
                        })
                        .onEnded({ val in
                            withAnimation(.easeInOut) {
                                    if(offsetVal < 0){
                                        if(selection < (tabs.count - 1)) {
                                            switchToTab(selection + 1)
                                        }
                                    } else {
                                        if(selection > 1) {
                                            switchToTab(selection - 1)
                                        } else {
                                            switchToTab(0)
                                        }
                                    }
//                                }
                                offsetVal = 0
                            }
                        })
                )
            if(hasIndicator) {
                VStack{
                    Spacer()
                    PagerIndicatorView(
                        selection: $selection,
                        tabs: tabs,
                        height: height,
                        selectedWidth: selectedWidth
                        , unSelectedWidth: unSelectedWidth
                        , marginBottom: marginBottom,
                        selectedColor: selectedColor,
                        unSelectedColor: unSelectedColor,
                        autoMove: false) {
                            background
                        }
                }
                .padding(.top, marginBottom)
            }
        }
        .onPreferenceChange(HasPagerIndicatorPreferenceKey.self) { value in
            self.hasIndicator = value
        }
        .onPreferenceChange(PagerItemsPreferenceKey.self) { items in
            self.tabs = items
        }
    }
    
    func switchToTab(_ index: Int) {
        withAnimation(.easeOut) {
            selection = index
        }
    }
    
}

fileprivate struct PreviewHelper : View {
    @State var selection : Int = 0
    @State var hasIndicator : Bool = true
    
    var body: some View {
        PagerContainerView(
            selection: $selection ,
            hasIndicator: $hasIndicator
        ) {
            Color.red
                .ignoresSafeArea()
        } background: {
            RoundedRectangle(cornerRadius: 10)
                .fill(
                    .green
                )
        }
    }
    
}

struct PagerContainerView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewHelper()
    }
}
