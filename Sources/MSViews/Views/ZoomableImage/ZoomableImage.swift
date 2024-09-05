//
//  ZoomableImage.swift
//  
//
//  Created by Mohamed safwat on 27/11/2023.
//

import SwiftUI

public struct ZoomableImage : View {
    public var link:String
    @Binding public var showDialog : Bool
    @State public var currentAmount: CGFloat = 0
    @State public var offset: CGFloat = 0
    public var onDismiss : ()->Void
    
    public init(
        link:String
        , showDialog : Binding<Bool>
        , onDismiss : @escaping ()->Void
    ) {
        self.link = link
        self._showDialog = showDialog
        self.onDismiss = onDismiss
    }
    
    public var body : some View {
        CommonNoButtonsDialog(dismissByClick: true, showDialog: $showDialog) {
            onDismiss()
        } content: {
            let imgUrl = URL(string: link)
            if let imgUrl {
                AsyncImage(url: imgUrl, scale: 1) { img in
                    img
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity , alignment:.center)
                        .foregroundColor(.gray)
                        .scaleEffect(1 + currentAmount)
                        .gesture(
                            MagnificationGesture()
                                .onChanged({ value in
                                    currentAmount = value - 1
                                })
                        )
                        .gesture(
                            DragGesture()
                                .onChanged{ val in
                                    let x = val.translation.width
                                    offset = x
                                    
                                    print(offset)
                                }
                                .onEnded{ val in
                                    
                                }
                        )
                        .offset(x:offset)
                } placeholder: {
                    
                }
            }
        }
    }
}
