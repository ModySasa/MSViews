//
//  SwiftUIView.swift
//  
//
//  Created by Corptia 02 on 25/04/2023.
//

import SwiftUI

public struct CheckBox: View {
    @Binding var isChecked : Bool?
    var text : String = strings("rememberMe")
    var isRound : Bool = false
    var isFilled : Bool = false
    var textColor : Color = msViews.viewsHelper.mainTextColor
    var textSize : CGFloat = 14
    var textWeight : Font.Weight = .regular
    
    var checkedColor : Color = msViews.viewsHelper.mainAppColor
    var fillColor : Color = msViews.viewsHelper.backgroundColor
    var unCheckedColor : Color = msViews.viewsHelper.secondBorderColor
    
    public init(isChecked: Binding<Bool?>, text: String = strings("rememberMe") , isRound : Bool = false , isFilled : Bool = false
                , textColor : Color = msViews.viewsHelper.mainTextColor
                , textSize : CGFloat = 14
                , textWeight : Font.Weight = .regular
                , checkedColor : Color = msViews.viewsHelper.mainAppColor
                , fillColor : Color = msViews.viewsHelper.backgroundColor
                , unCheckedColor : Color = msViews.viewsHelper.secondBorderColor
    ) {
        self._isChecked = isChecked
        self.text = text
        self.isRound = isRound
        self.isFilled = isFilled
        self.textColor = textColor
        self.textSize = textSize
        self.textWeight = textWeight
        self.checkedColor = checkedColor
        self.fillColor = fillColor
        self.unCheckedColor = unCheckedColor
    }
    
    public var body: some View {
        HStack(spacing: 11) {
            box
            Text(text)
                .textStyle(.placeHolder)
                .foregroundColor(textColor)
        }
        .onTapGesture {
            withAnimation(.easeIn) {
                if(isChecked != nil) {
                    isChecked!.toggle()
                } else {
                    isChecked = true
                }
            }
        }
    }
    
    private var box : some View {
        RoundedRectangle(cornerRadius: isRound ? 10 : 3.25)
            .stroke(lineWidth: 1)
            .frame(width: 20, height: 20 , alignment: .center)
            .foregroundColor(
                isChecked ?? false ? checkedColor : unCheckedColor
            )
            .cornerRadius(isRound ? 11.5 : 3.25)
            .overlay(alignment: .center) {
                ZStack {
                    if(isFilled) {
                        if(isChecked ?? false) {
                            checkedColor
                        } else {
                            fillColor
                        }
                    }
                    img
                }
                .cornerRadius(isRound ? 11.5 : 3.25)
            }
    }
    
    private var img : some View {
        Image(systemName: "checkmark")
            .resizable()
            .font(.system(size: 10).weight(.heavy))
            .foregroundColor(
                isFilled ? fillColor : checkedColor
            )
            .opacity(isChecked ?? false ? 1 : 0)
            .frame(width: 10, height: 10)
            .scaledToFit()
    }
    
}

struct CheckBoxPreviewHelper : View {
    @State var isChecked : Bool? = true
    
    var body: some View {
        ZStack {
            Color.white
            CheckBox(isChecked: $isChecked , isRound: true , isFilled: true)
        }
    }
}

struct CheckBox_Previews: PreviewProvider {
    static var previews: some View {
        CheckBoxPreviewHelper()
    }
}
