//
//  SwiftUIView.swift
//  
//
//  Created by Corptia 02 on 24/05/2023.
//

import SwiftUI

struct BottomDrawer: View {
    let maxHeight : CGFloat
    let minDragOffset = msViews.viewsHelper.screenWidth() * -0.5
    let maxDragOffset = msViews.viewsHelper.screenWidth() * 1 / 4
    
    let minWidth = 50.0
    let maxWidth = msViews.viewsHelper.screenWidth() * 3 / 4
    
    @State var offset : CGFloat = 0
    
    var body: some View {
        ZStack{
            Color.purple
                .ignoresSafeArea()
            HStack{
                Text("Hello there")
                Image(systemName: "chevron.right")
            }
            .foregroundColor(.black)
            .font(.body)
            .frame(maxHeight: .infinity)
            .frame(width: (maxWidth + minWidth) * offset / (maxDragOffset + minDragOffset) < 0 ? 50 : (-1.0 * (maxWidth + minWidth) * offset / (maxDragOffset + minDragOffset)))
            .background(
                Rectangle()
                    .fill(.white)
                    .cornerRadius(10, corners: [.topLeft , .topRight])
            )
            .gesture(
                DragGesture()
                    .onChanged{ val in
                        withAnimation {
                            let x = val.translation.width
                            if(x > minDragOffset) {
                                if(x < maxDragOffset) {
                                    offset = x
                                } else {
                                    offset = maxDragOffset
                                }
                            } else {
                                offset = minDragOffset
                            }
                        }
                    }
                    .onEnded{ val in
                        
                    })
            .offset(x:offset)
            .edgesIgnoringSafeArea(.bottom)
        }
        .onAppear {
            self.offset = minDragOffset
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        BottomDrawer(maxHeight: 200)
    }
}
