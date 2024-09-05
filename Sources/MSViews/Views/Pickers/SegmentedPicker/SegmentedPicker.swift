//
//  SwiftUIView.swift
//  
//
//  Created by Mohamed safwat on 09/12/2023.
//

import SwiftUI

public struct SegmentedPicker: View {
    @Binding var selectedIndex : Int
    var segments : [String]
    
    var isHorizontal : Bool = false
    var isSwapColors : Bool = false
    var isSelectedBordered : Bool = false
    var isNormallyBordered : Bool = false
    
    var spacing : CGFloat = 10
    var height : CGFloat = 50
    var width : CGFloat = 100
    var cornerRadius : CGFloat = 10
    
    var selectedBackgroundColor : Color = .green
    var unSelectedBackgroundColor : Color = .white
    var selectedBorderColor : Color = .white
    var unSelectedBorderColor : Color = .white
    
    var selectedTextSize : CGFloat = 10
    var unSelectedTextSize : CGFloat = 10
    
    var selectedTextColor : Color = .white
    var unSelectedTextColor : Color = .green
    
    var selectedTextWeight : Font.Weight = .bold
    var unSelectedTextWeight : Font.Weight = .bold
    
    public init(
        selectedIndex: Binding<Int>
        , segments: [String]
        , isHorizontal: Bool = true
        , isSwapColors: Bool = true
        , isSelectedBordered: Bool = false
        , isNormallyBordered: Bool = true
        , spacing: CGFloat = 10
        , height: CGFloat = 50
        , width: CGFloat = 100
        , cornerRadius: CGFloat = 10
        , selectedBackgroundColor: Color = .purple
        , unSelectedBackgroundColor: Color = .white
        , selectedBorderColor: Color = .white
        , unSelectedBorderColor: Color = .white
        , selectedTextSize: CGFloat = 10
        , unSelectedTextSize: CGFloat = 10
        , selectedTextColor: Color = .white
        , unSelectedTextColor: Color = .purple
        , selectedTextWeight: Font.Weight = .bold
        , unSelectedTextWeight: Font.Weight = .bold
    ) {
        self._selectedIndex = selectedIndex
        self.segments = segments
        self.isHorizontal = isHorizontal
        self.isSwapColors = isSwapColors
        self.isSelectedBordered = isSelectedBordered
        self.isNormallyBordered = isNormallyBordered
        self.spacing = spacing
        self.height = height
        self.width = width
        self.cornerRadius = cornerRadius
        self.selectedBorderColor = selectedBorderColor
        self.unSelectedBorderColor = unSelectedBorderColor
        self.selectedBackgroundColor = selectedBackgroundColor
        self.unSelectedBackgroundColor = unSelectedBackgroundColor
        self.selectedTextSize = selectedTextSize
        self.unSelectedTextSize = unSelectedTextSize
        if(!self.isSwapColors) {
            self.selectedTextColor = selectedTextColor
            self.unSelectedTextColor = unSelectedTextColor
        } else {
            self.selectedTextColor = unSelectedBackgroundColor
            self.unSelectedTextColor = selectedBackgroundColor
        }
        self.selectedTextWeight = selectedTextWeight
        self.unSelectedTextWeight = unSelectedTextWeight
    }
    
    public var body: some View {
        mainBody
    }
    
    @ViewBuilder
    var mainBody: some View {
        if(isHorizontal) {
            HStack(spacing:spacing) {
                segmentsView
            }
        } else {
            VStack{
                segmentsView
            }
        }
    }
    @Namespace private var nameSpace
    var segmentsView : some View {
        ForEach(
            0..<segments.count
        ) { segIndex in
            let isSelected = segIndex == selectedIndex
            RoundedRectangle(cornerRadius: cornerRadius)
                .frame(maxWidth: width , idealHeight:height)
                .foregroundColor(isSelected ? selectedBackgroundColor : unSelectedBackgroundColor)
                .overlay(alignment: .center) {
                    Text(segments[segIndex])
                        .textStyle(.custom, size: isSelected ? selectedTextSize : unSelectedTextSize, lineSpacing: 0, monoSpacing: 0, fontWeight: isSelected ? selectedTextWeight : unSelectedTextWeight)
                        .foregroundColor(isSelected ? selectedTextColor : unSelectedTextColor)
//                        .frame(height: height)
//                        .frame(maxWidth: isHorizontal ? .infinity : width)
                }
                .background(
                    rect(isSelected)
                )
                .overlay(alignment: .center, content: {
                    Rectangle()
                        .foregroundColor(.black.opacity(0.01))
                        .onTapGesture {
                            withAnimation {
                                selectedIndex = segIndex
                            }
                        }
                })
        }
    }
    
    @ViewBuilder
    func rect(_ selected : Bool) -> some View {
        if(selected) {
            if(isSelectedBordered) {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: 1)
                    .foregroundColor(selectedBorderColor)
            } else {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .foregroundColor(.black)
//                    .matchedGeometryEffect(id: "rect_background", in: nameSpace)
            }
        } else {
            if(isNormallyBordered) {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: 1)
                    .foregroundColor(unSelectedBorderColor)
            } else {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .foregroundColor(unSelectedBackgroundColor)
            }
        }
    }
}

struct SegmentedPickerHelper : View {
    @State var selectedIndex = 0
    var segments = [String].init(arrayLiteral: "Seg 1" , "Seg 2")
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing:0){
                HStack(spacing:7) {
                    Image(systemName: "heart")
                    Text("pickInsuranceType")
                    Spacer()
                }
                .padding(.bottom , 30)
                SegmentedPicker(
                    selectedIndex: $selectedIndex
                    , segments: ["Test 1" , "Test 2"]
                    , isHorizontal: true
                    , isSwapColors: false
                    , isSelectedBordered: true
                    , isNormallyBordered: true
                    , spacing: 6
                    , height: 39
                    , width: .infinity
                    , cornerRadius: 10
                    , selectedBackgroundColor: .red
                    , unSelectedBackgroundColor: .green
                    , selectedBorderColor: .blue
                    , unSelectedBorderColor: msViews.viewsHelper.secondBorderColor
                    , selectedTextSize: 10
                    , unSelectedTextSize: 10
                    , selectedTextColor: .gray
                    , unSelectedTextColor: .gray
                    , selectedTextWeight: .bold
                    , unSelectedTextWeight: .bold
                )
            }
        }
    }
}

struct SegmentedPicker_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedPickerHelper()
    }
}
