//
//  SwiftUIView.swift
//  
//
//  Created by Corptia 02 on 21/05/2023.
//

import SwiftUI

struct PagerExample: View{
    @State var selection : Int = 0
    @State var hasIndicators : Bool = true
    var count = 5
    
    var body: some View {
        PagerContainerView(
            selection: $selection,
            hasIndicator: $hasIndicators
            , selectedColor: .green
            , unSelectedColor: .blue
            , marginBottom: 10
            , selectedWidth: 30
            , unSelectedWidth: 10
            , height: 10
        ) {
            RoundedRectangle(cornerRadius: 10)
                .fill(.yellow)
                .frame(width: 100, height: 100)
                .pagerItem(
                    .init(0)
                    , selection: $selection
                )
            RoundedRectangle(cornerRadius: 10)
                .fill(.green)
                .frame(width: 100, height: 100)
                .pagerItem(
                    . init(1)
                    , selection: $selection
                )
        } background: {
            Rectangle()
                .fill(
                    .clear
                )
        }
        .frame(width: 100)
        .frame(maxHeight: 200)
    }
}

struct PagerExample_Previews: PreviewProvider {
    static var previews: some View {
        PagerExample()
    }
}
