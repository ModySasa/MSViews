//
//  SwiftUIView.swift
//  
//
//  Created by Corptia 02 on 27/08/2023.
//

import SwiftUI

public struct SliderContainerView: View {
    @Binding var selection : Int
    @Binding var list : [PagerItem]
    @Binding var hasIndicator : Bool
    let unSelectedColor : Color
    let selectedColor : Color
    let selectedWidth : CGFloat
    let marginBottom : CGFloat
    let unSelectedWidth : CGFloat
    let height : CGFloat
    let itemWidth : CGFloat
    let padding : CGFloat
    let duration : Int
    let autoMove : Bool
    let tapContent : (PagerItem)->AnyView
    
    public init(
        selection :Binding<Int>
        , list : Binding<[PagerItem]>
        , hasIndicator : Binding<Bool>
        , selectedColor: Color = .green
        , unSelectedColor: Color = .blue
        , marginBottom: CGFloat = 10
        , selectedWidth: CGFloat = 10
        , unSelectedWidth: CGFloat = 10
        , height: CGFloat = 20
        , itemWidth: CGFloat = msViews.viewsHelper.screenWidth() - 2 * msViews.margins.mainMarginHorizontal
        , padding: CGFloat = 12
        , duration: Int = 2
        , autoMove: Bool = true
        , tapContent :  @escaping (PagerItem)->AnyView
    ) {
        self.duration = duration
        self.autoMove = autoMove
        self._selection = selection
        self._hasIndicator = hasIndicator
        self.selectedColor = selectedColor
        self.unSelectedColor = unSelectedColor
        self.marginBottom = marginBottom
        self.selectedWidth = selectedWidth
        self.unSelectedWidth = unSelectedWidth
        self.height = height
        self.tapContent = tapContent
        self._list = list
        self.itemWidth = itemWidth
        self.padding = padding
    }
    
    @State var offsetVal : CGFloat = 0
    
    public var body: some View {
        VStack(spacing:marginBottom) {
            HStack(spacing:0) {
                ForEach(list) { item in
                    HStack(spacing:0){
                        tapContent(item)
                    }
                    .frame(
                        width:itemWidth
                        ,alignment: .center)
                    .padding(.leading, padding)
                }
                .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing)))
                .offset(x:offsetVal)
                .onChange(of: selection) { newValue in
                    withAnimation(.easeInOut) {
                        let wid = itemWidth + padding
//                        if(msViews.langMethods.isArabic())  {
//                            offsetVal = CGFloat(newValue) * -wid
//                        } else {
                            offsetVal = CGFloat(newValue) * -wid
//                        }
                    }
                }
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            let wid = itemWidth + padding
                            var newValue = 0
                            if ((selection + 1) == list.count) {
                                newValue = 0
                            } else {
                                newValue += 1
                            }
//                            if(msViews.langMethods.isArabic())  {
//                                offsetVal = CGFloat(newValue) * wid
//                            } else {
                                offsetVal = CGFloat(newValue) * -wid
//                            }
                        })
                        .onEnded({ val in
                            withAnimation(.easeInOut) {
                                if(val.translation.width < 0){
                                    if(selection < (list.count - 1)) {
                                        switchToTab(selection + 1)
                                    } else {
                                        switchToTab(0)
                                    }
                                } else {
                                    if(selection > 0) {
                                        switchToTab(selection - 1)
                                    } else {
                                        switchToTab(list.count - 1)
                                    }
                                }
                                //                                }
                            }
                        })
                )
            }
            .frame(maxWidth: msViews.viewsHelper.screenWidth(),alignment: .leading)
            if(hasIndicator) {
                PagerIndicatorView(
                    selection: $selection,
                    tabs: list,
                    height: height,
                    selectedWidth: selectedWidth
                    , unSelectedWidth: unSelectedWidth
                    , marginBottom: marginBottom
                    , selectedColor: selectedColor
                    , unSelectedColor: unSelectedColor
                    , autoMove: autoMove
                    , background: {
                    }
                    , duration: duration
                )
            }
        }
       
        .onPreferenceChange(HasPagerIndicatorPreferenceKey.self) { value in
            self.hasIndicator = value
        }
    }
    
    func switchToTab(_ index: Int) {
        withAnimation(.easeOut) {
            selection = index
        }
    }
    
}


struct SliderContainerViewPreviewHelper : View {
    @State var selection : Int = 0
    @State var list : [PagerItem] = .init(arrayLiteral:
            .init(0)
                                          ,.init(1)
                                          ,.init(2)
                                          ,.init(3)
    )
    func getColor() -> Color {
        var clr = Color.red
        switch selection {
        case 0: clr = .gray
            break
        case 1: clr = .green
            break
        case 2: clr = .blue
            break
        default: clr = .red
        }
        return clr
    }
    var body: some View {
        SliderContainerView(
            selection: $selection
            , list: $list
            , hasIndicator: .constant(true)
            , selectedColor: .red
            , unSelectedColor: .gray
            , marginBottom: 10
            , selectedWidth: 30
            , unSelectedWidth: 10
            , height: 10
            , itemWidth: msViews.viewsHelper.screenWidth()
            , padding : 0
            , duration: 5
            , autoMove: true) { item in
                AnyView(
//                    Text("Hello \(item.index)")
//                        .frame(width: msViews.viewsHelper.screenWidth() - 20)
//                        .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(getColor())
//                )
                )
            }
    }
}

struct SliderContainerViewPreview : PreviewProvider {
    static var previews: some View {
        SliderContainerViewPreviewHelper()
    }
}
