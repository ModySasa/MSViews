//
//  SwiftUIView.swift
//  
//
//  Created by Mohamed safwat on 11/11/2023.
//

import SwiftUI

public struct CustomMenu<Content:View>: View {
    @Binding var isPresented: Bool
    @Binding var selectedIndex: Int
    var backgroundColor: Color = .white.opacity(0.1)
    var rectBackgroundColor: Color = .white
    let cornerRadius: CGFloat
    let items: [String]
    let tappedImagePosition: CGPoint
    let tappedImageHeight: CGFloat
    var onDismiss:()->Void
    var content:(String , Bool) -> Content

    public init(
        isPresented: Binding<Bool>
        , selectedIndex: Binding<Int>
        , backgroundColor: Color  = .white.opacity(0.1)
        , rectBackgroundColor: Color  = .white
        , cornerRadius: CGFloat
        , items: [String]
        , tappedImagePosition: CGPoint
        , tappedImageHeight: CGFloat
        , onDismiss: @escaping ()->Void
        , content: @escaping (String , Bool)->Content
    ) {
        self._isPresented = isPresented
        self._selectedIndex = selectedIndex
        self.backgroundColor = backgroundColor
        self.rectBackgroundColor = rectBackgroundColor
        self.cornerRadius = cornerRadius
        self.items = items
        self.tappedImagePosition = tappedImagePosition
        self.tappedImageHeight = tappedImageHeight
        self.onDismiss = onDismiss
        self.content = content
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Clear background view to capture touch events
                BlurView(color:backgroundColor , opacity: 1)
                // Rounded Rectangle with a list of items
                VStack {
                    ForEach(0..<items.count) { index in
                        content(items[index] , index == selectedIndex)
                            .onTapGesture {
                                withAnimation {
                                    selectedIndex = index
                                    isPresented = false
                                }
                            }
                    }
                }
                .frame(maxWidth: 350)
                .padding(.horizontal , msViews.margins.mainMarginHorizontal)
                .background(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .foregroundColor(rectBackgroundColor)
                )
                .position(
                    x: (geometry.size.width - cornerRadius) / 2,
                    y: getY(geo: geometry)
                )

            }
        }
        .opacity(isPresented ? 1 : 0)
        .onTapGesture {
            withAnimation {
                isPresented = false
            }
        }
        .onDisappear {
            withAnimation {
                onDismiss()
            }
        }
    }
    func getY(geo:GeometryProxy) -> CGFloat {
//        var y = tappedImagePosition.y - (tappedImageHeight / 2) - 20 - (geo.size.height / 2)
//        if ( y < geo.size.height + 50 + 20) {
//            var y = tappedImagePosition.y + (tappedImageHeight / 2) + 20 + (geo.size.height / 2)
//        }
//        return y
        return min(max(tappedImagePosition.y , cornerRadius), geo.size.height - cornerRadius)
    }
}

extension View {
    public func menuButton(tappedImagePosition:Binding<CGPoint> , tappedImageHeight:Binding<CGFloat> , showMenu : Binding<Bool> )->some View {
        overlay(content: {
            GeometryReader { geometry in
                Rectangle()
                    .frame(width: 30, height: 30, alignment: .center)
                    .foregroundColor(.white.opacity(0.01))
                    .onTapGesture {
                        tappedImageHeight.wrappedValue = geometry.size.height
                        tappedImagePosition.wrappedValue = CGPoint(
                            x: geometry.frame(in: .global).midX
                            , y: geometry.frame(in: .global).midY
                        )
                        withAnimation {
                            showMenu.wrappedValue.toggle()
                        }
                    }
            }
        })
    }
}

//struct CustomMenu_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomMenu()
//    }
//}
