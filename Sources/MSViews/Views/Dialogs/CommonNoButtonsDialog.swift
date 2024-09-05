//
//  CommonNoButtonsDialog.swift
//  VisionDimensions
//
//  Created by Corptia 02 on 15/05/2023.
//

import SwiftUI

public struct CommonNoButtonsDialog<Content : View>: View {
    @Binding public var showDialog : Bool
    public var content : Content
    public var onDismiss : (()->Void)! = nil
    public var dismissByClick : Bool = false
    public var blurColor : Color = Color.black
    public var blurOpacity : CGFloat = 0.8
    public var backgroundRadius : CGFloat = 8
    public var topBackgroundPadding : CGFloat = 40
    public var backgroundColor : Color = .white
    
    public init (
        dismissByClick:Bool = false,
        showDialog:Binding<Bool>,
        blurColor : Color = Color.black,
        blurOpacity : CGFloat = 0.8,
        topBackgroundPadding : CGFloat = 40,
        backgroundRadius : CGFloat = 8,
        backgroundColor : Color = .white,
        onDismiss : @escaping () -> Void ,
        @ViewBuilder content: () -> Content
    ) {
        self._showDialog = showDialog
        self.content = content()
        self.dismissByClick = dismissByClick
        self.onDismiss = onDismiss
        self.blurColor = blurColor
        self.blurOpacity = blurOpacity
        self.backgroundColor = backgroundColor
        self.backgroundRadius = backgroundRadius
        self.topBackgroundPadding = topBackgroundPadding
    }
    
    public var body: some View {
        ZStack(alignment: .center){
            BlurView(color: blurColor, opacity: blurOpacity)
                .onTapGesture {
                    if(dismissByClick) {
                        showDialog = false
                    }
                }
            content
            .padding(.horizontal, 72)
            .padding(.bottom, 24)
            .padding(.top, 24)
            .background(
                RoundedRectangle(cornerRadius: backgroundRadius)
                    .fill(backgroundColor)
                    .frame(
                        width: msViews.viewsHelper.screenWidth() - (36.0 * 2.0)
                    )
            )
        }
        .padding(.top, topBackgroundPadding)
        .onDisappear {
            if let dismiss = onDismiss {
                dismiss()
            }
        }
        .ignoresSafeArea()
    }
}

fileprivate struct PreviewHelper : View{
    @State var showDialog = true
    var body: some View {
        CommonNoButtonsDialog(showDialog: $showDialog) {
            
        } content :{
            Text("Hello, World!")
        }
    }
}

struct CommonNoButtonsDialog_Previews: PreviewProvider {
    static var previews: some View {
        PreviewHelper()
    }
}
