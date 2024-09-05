//
//  SwiftUIView.swift
//  
//
//  Created by Corptia 02 on 10/04/2023.
//

import SwiftUI

public struct RatingView: View {
    @Binding public var rating : Double
    var isViewOnly = true
    var hasBackgroundCircle = false
    var backgroundPadding : CGFloat
    var backgroundColor : Color
    var spacing : CGFloat
//    var filledColor : Color
//    var unSelectedColor : Color
    
    public init(
        rating: Binding<Double>
        , isViewOnly: Bool = true
        , hasBackgroundCircle : Bool = false
        , backgroundPadding : CGFloat = 11
        , backgroundColor : Color = .clear
        , spacing: CGFloat = 5
    ) {
        self._rating = rating
        self.isViewOnly = isViewOnly
        self.hasBackgroundCircle = hasBackgroundCircle
        self.backgroundPadding = backgroundPadding
        self.backgroundColor = backgroundColor
        self.spacing = spacing
    }
    
    public var body: some View {
        ZStack {
            starsView
                .overlay(alignment: .leading) {
                    overlayView.mask {starsView}
                }
            emptyStarsView
        }
    }
    
    private var overlayView : some View {
        GeometryReader { geometry in
            Rectangle()
                .frame(width: (CGFloat(rating / 5.0) * geometry.size.width))
                .foregroundColor(msViews.viewsHelper.filledColor)
        }
        .allowsHitTesting(false)
    }
    
    private var starsView : some View {
        HStack (alignment: .center, spacing:spacing) {
            ForEach(1..<6) { index in
                Image(systemName: "star.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(
                        rating >= Double(index) ?
                        msViews.viewsHelper.filledColor
                        : msViews.viewsHelper.emptyColor
                    )
                    .padding(hasBackgroundCircle ? backgroundPadding : 0)
                    .background(
                        Circle()
                            .foregroundStyle(backgroundColor)
                    )
                    .onTapGesture {
                        if(!isViewOnly){
                            withAnimation {
                                rating = Double(index)
                            }
                        }
                    }
            }
        }
    }
    
    private var emptyStarsView : some View {
        HStack (alignment: .center, spacing:spacing) {
            ForEach(1..<6) { index in
                Image(systemName: "star")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(
                        rating >= Double(index) ?
                        msViews.viewsHelper.filledBorderColor
                        : msViews.viewsHelper.emptyBorderColor
                    )
                    .onTapGesture {
                        if(!isViewOnly){
                            withAnimation {
                                rating = Double(index)
                            }
                        }
                    }
            }
        }
    }
}

struct RateViewPreviewHelper : View {
    @State var rate = 4.0
    
    var body: some View {
        RatingView(rating: $rate, isViewOnly: false)
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RateViewPreviewHelper()
    }
}
