//
//  RangeSlider.swift
//  
//
//  Created by Mohamed safwat on 04/11/2023.
//

import SwiftUI

public struct RangeSlider<Labels:View>: View {
    @Binding var lowerValue: Double
    @Binding var upperValue: Double
    
    var rippleWidth : CGFloat = 24
    var inRangeColor : Color = .orange
    var outRangeColor : Color = .orange.opacity(0.4)
    var ribbleStrokeWidth : CGFloat = 1
    var ribbleStrokeColor : Color = .white
    var lineHeight : CGFloat = 1
    var hasLabel : Bool = true
    var labelPadding : CGFloat = 16
    
    var labels : Labels
    
    var hasLower : Bool
    var hasUpper : Bool
    @State var lowerConversion = 1.0
    @State var upperConversion = 1.0
    
    @State var initialLower = 0.0
    @State var initialUpper = 0.0
    @State var difference = 0.0
    
    public init(
        lowerValue: Binding<Double>
        , upperValue: Binding<Double>
        , rippleWidth: CGFloat = 24
        , inRangeColor: Color = Color.orange
        , outRangeColor: Color = Color.orange.opacity(0.4)
        , ribbleStrokeWidth: CGFloat = 1
        , ribbleStrokeColor: Color = Color.white
        , lineHeight: CGFloat = 1
        , hasLabel: Bool = true
        , labelPadding: CGFloat = 16
        , hasLower : Bool = true
        , hasUpper : Bool = true
        , labels: @escaping () -> Labels
    ) {
        self._lowerValue = lowerValue
        self._upperValue = upperValue
        self.rippleWidth = rippleWidth
        self.inRangeColor = inRangeColor
        self.outRangeColor = outRangeColor
        self.ribbleStrokeWidth = ribbleStrokeWidth
        self.ribbleStrokeColor = ribbleStrokeColor
        self.lineHeight = lineHeight
        self.hasLabel = hasLabel
        self.labelPadding = labelPadding
        self.hasLower = hasLower
        self.hasUpper = hasUpper
        self.labels = labels()
        self.lowerConversion = self.lowerValue / 100
        self.upperConversion = self.upperValue / 100
    }
    
    public var body: some View {
        RangeSlider
            .onAppear(perform: {
                var vals = [CGFloat]()
                vals.append(lowerValue)
                vals.append(upperValue)
                
                initialLower = vals[0]
                initialUpper = vals[1]
                difference = vals[1] - vals[0]
            })
            .environment(\.layoutDirection, .leftToRight)
    }
    
    var RangeSlider : some View {
        GeometryReader { proxy in
            let width = proxy.size.width - (2 * rippleWidth)
            ZStack(alignment:.topLeading){
                unSelectedRect
                selectedRect(width)
                lowerRibble(width,proxy)
                higherRibble(width,proxy)
                labelsView
            }
        }
    }
    
    var ribble : some View {
        ZStack(alignment: .center) {
            Circle()
                .frame(height:rippleWidth)
                .foregroundColor(inRangeColor)
            
            Circle()
                .stroke(lineWidth: ribbleStrokeWidth)
                .frame(height:rippleWidth)
                .foregroundColor(ribbleStrokeColor)
        }
    }
    
    var unSelectedRect : some View {
        RoundedRectangle(cornerRadius: lineHeight)
            .frame(height: lineHeight)
            .foregroundColor(
                outRangeColor
            )
            .padding(.top , rippleWidth / 2)
    }
    
    @ViewBuilder
    func selectedRect(_ width:CGFloat ) -> some View {
        RoundedRectangle(cornerRadius: lineHeight)
            .frame(height: lineHeight)
            .foregroundColor(
                inRangeColor
            )
            .mask(alignment: .leading) {
                HStack{
                    RoundedRectangle(cornerRadius: lineHeight)
                }
                .padding(.leading, ((lowerValue - initialLower) * width / difference))
                .padding(.trailing, (initialUpper - upperValue) * width / difference)
            }
            .padding(.top , rippleWidth / 2)
    }
    
    @ViewBuilder
    var labelsView : some View {
        if(hasLabel) {
            labels
            .padding(.top, (labelPadding + rippleWidth))
        }
    }
    
    @ViewBuilder
    func lowerRibble(_ width:CGFloat , _ proxy:GeometryProxy) -> some View {
        ribble
            .padding(.leading, (lowerValue - initialLower) * width / difference)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        let trackWidth = width
                        let touchX = value.location.x - rippleWidth // Adjust for track offset
                        let clampedX = max(0, min(touchX, trackWidth))
                        let newLower = initialLower + (clampedX / trackWidth) * difference
                        lowerValue = min(newLower, upperValue)
                    }
            )
            .opacity(hasLower ? 1 : 0)
    }
    
    @ViewBuilder
    func higherRibble(_ width:CGFloat , _ proxy:GeometryProxy) -> some View {
        ribble
            .frame(maxWidth: .infinity , alignment: .trailing)
            .padding(.trailing, (initialUpper - upperValue) * width / difference)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        let trackWidth = width
                        let touchX = value.location.x - rippleWidth // Adjust for track offset
                        let clampedX = max(0, min(touchX, trackWidth))
                        let newUpper = initialLower + (clampedX / trackWidth) * difference
                        upperValue = max(newUpper, lowerValue)
                    }
            )
            .opacity(hasUpper ? 1 : 0)
    }
    
    
    var isArabic : Bool {
        get {
            return msViews.langMethods.isArabic()
        }
    }
    
}
fileprivate struct RangeSliderPreviewHelper : View {
    @State var lowrPice : Double = 300.0
    @State var highestPrice : Double = 100000.0
    
    var body: some View {
        VStack {
            RangeSlider.init(
                lowerValue: $lowrPice
                , upperValue: $highestPrice
                , labels: {
                    HStack {
                        HStack(spacing: 2) {
                            Text(msViews.fixNumbers.fixDouble(number: lowrPice, 3))
                            Text("egp")
                        }
                        Spacer()
                        HStack(spacing: 2) {
                            Text(msViews.fixNumbers.fixDouble(number: highestPrice, 3))
                            Text("egp")
                        }
                    }
                }
            )
        }
        .padding()
    }
}

struct RangeSlider_Previews: PreviewProvider {
    static var previews: some View {
        RangeSliderPreviewHelper()
    }
}
