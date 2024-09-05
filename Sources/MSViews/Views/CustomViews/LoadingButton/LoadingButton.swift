//
//  SwiftUIView.swift
//  
//
//  Created by Corptia 02 on 04/04/2023.
//

import SwiftUI

public struct LoadingButton: View {
    @Binding var myState:ButtonState
    
    var width = msViews.viewsHelper.screenWidth()
    var height = msViews.margins.mainButtonHeight
    var isInverted : Bool = true
    var buttonText : String
    var buttonImage : String
    var fontWeight : Font.Weight = .bold
    var radius : CGFloat = 10
    var onClicked : (()-> Void)!
    var mainColor = msViews.viewsHelper.mainButtonColor
    var mainTextColor = msViews.viewsHelper.mainButtonTextColor
    var disabledButtonColor = Color.gray
    var disabledButtonTextColor = Color.gray
    var disabledTextColor = msViews.viewsHelper.mainButtonTextColor
    var hasCustomRadius: Bool = false
    var topLeadingCorner: CGFloat = 0
    var topTrailingCorner: CGFloat = 0
    var bottomLeadingCorner: CGFloat = 0
    var bottomTrailingCorner: CGFloat = 0
    
    public init(
        myState: Binding<ButtonState> ,
        width: CGFloat = msViews.viewsHelper.screenWidth(),
        height: CGFloat! = nil,
        isInverted: Bool = false,
        buttonText: String,
        buttonImage : String = "" ,
        fontWeight: Font.Weight = .bold,
        radius : CGFloat = 10,
        mainColor:Color = msViews.viewsHelper.mainButtonColor,
        mainTextColor:Color = msViews.viewsHelper.mainButtonTextColor,
        disabledButtonColor:Color = Color.gray,
        hasCustomRadius: Bool = false ,
        topLeadingCorner : CGFloat = 0,
        topTrailingCorner : CGFloat = 0,
        bottomLeadingCorner : CGFloat = 0,
        bottomTrailingCorner : CGFloat = 0,
        onClicked: @escaping () -> Void
    ) {
        self._myState = myState
        self.width = width
        if(height != nil){
            self.height = height
        }
        self.isInverted = isInverted
        self.buttonText = buttonText
        self.buttonImage = buttonImage
        self.fontWeight = fontWeight
        self.onClicked = onClicked
        self.radius = radius
        self.mainColor = mainColor
        self.mainTextColor = mainTextColor
        self.disabledButtonColor = disabledButtonColor
        self.hasCustomRadius = hasCustomRadius
        self.topLeadingCorner = topLeadingCorner
        self.topTrailingCorner = topTrailingCorner
        self.bottomLeadingCorner = bottomLeadingCorner
        self.bottomTrailingCorner = bottomTrailingCorner
    }
    
    public var body: some View {
        if(isInverted) {
            GeometryReader { geo in
                RoundedRectangle(cornerRadius: radius)
                    .background{
                        RoundedRectangle(cornerRadius: radius)
                            .stroke(lineWidth: 1.5)
                            .foregroundStyle(getColor())
                            .overlay(content: {
                                RoundedRectangle(cornerRadius: 9)
                                    .foregroundStyle(
                                        Color.white.opacity(0.1)
                                    )
                            })
                    }
                    .overlay(alignment: .center) {
                        if (myState == .Loading) {
                            ProgressView()
                                .scaleEffect(1.5)
                                .tint(mainColor)
                                .progressViewStyle(.circular)
                        } else {
                            HStack(alignment: .center){
                                if(!buttonImage.isEmpty) {
                                    Image(buttonImage)
                                }
                                Text(buttonText)
                                    .textStyle(.button)
                                    .foregroundColor(
                                        mainColor
                                    )
                            }
                            .padding(
                                .horizontal ,
                                msViews.margins.mainMarginHorizontal
                            )
                            .frame(
                                maxWidth: (geo.size.width - 3),
                                maxHeight: height - 3
                            )
                            .background(
                                .white
                            )
                            .cornerRadius(radius)
                        }
                    }
                    .onTapGesture {
                        myState = .Loading
                        if let clicked = onClicked {
                            clicked()
                        }
                    }
                    .allowsHitTesting(getIsClickable())
            }
            .frame(
                maxWidth: width
            )
            .frame(height: height)
            .foregroundColor(
                getColor()
            )
        } else {
            rectangle
                .frame(
                    maxWidth: width
                )
                .frame(height: height)
                .foregroundColor(
                    getColor()
                )
                .overlay(alignment: .center) {
                    if (myState == .Loading) {
                        ProgressView()
                            .scaleEffect(1.5)
                            .tint(.white)
                            .progressViewStyle(.circular)
                    } else {
                        HStack(alignment: .center){
                            if(!buttonImage.isEmpty) {
                                Image(buttonImage)
                            }
                            Text(buttonText)
                                .foregroundColor(mainTextColor)
                        }
                        
                    }
                }
                .onTapGesture {
                    myState = .Loading
                    if let clicked = onClicked {
                        clicked()
                    }
                }
                .allowsHitTesting(getIsClickable())
        }
    }
    
    @ViewBuilder var rectangle: some View{
        if hasCustomRadius{
            Rectangle()
                .cornerRadius(topLeadingCorner, corners: msViews.langMethods.isArabic() ? .topRight : .topLeft)
                .cornerRadius(bottomLeadingCorner, corners: msViews.langMethods.isArabic() ? .bottomRight : .bottomLeft)
                .cornerRadius(bottomTrailingCorner, corners: msViews.langMethods.isArabic() ? .bottomLeft : .bottomRight)
                .cornerRadius(topTrailingCorner, corners:msViews.langMethods.isArabic() ? .topLeft : .topRight)
        }else{
            RoundedRectangle(cornerRadius: radius)
        }
    }
    
    private func getIsClickable() -> Bool {
        switch myState {
        case .Enabled:
            return true
        default :
            return false
        }
    }
    
    private func getColor() -> Color {
        if(myState == .Disabled) {
            return disabledButtonColor
        } else {
            return mainColor
        }
    }
    
}

struct LoadingButtonPreviewHelper : View {
    @State var loadingCase:ButtonState = .Disabled
    
    var body : some View {
        ZStack {
            Color.black.ignoresSafeArea()
            LoadingButton(
                myState: $loadingCase,
                width: 200,
                isInverted: false,
                buttonText: "Click me",
                hasCustomRadius: false,
                topLeadingCorner:15.resize(),
                bottomTrailingCorner:28.resize()) {
                    
                }
        }
    }
}

struct LoadingButton_Previews: PreviewProvider {
    static var previews: some View {
        LoadingButtonPreviewHelper()
    }
}

public enum ButtonState {
    case Loading
    case Enabled
    case Disabled
    case Link
}
