//
//  File.swift
//  
//
//  Created by Corptia 02 on 06/04/2023.
//

import Foundation
import SwiftUI
import L10n_swift

struct StylePreview : PreviewProvider {
    static var previews: some View {
        Text(strings("Sign up"))
            .textStyle(.custom , size: 14 , lineSpacing: 16 , monoSpacing: 50)
    }
}

struct TitleModifier : ViewModifier {
    var fontWeight : Font.Weight = .medium
    
    func body(content:Content) -> some View {
        if #available(iOS 16.0, *) {
            content
                .font(.custom(getAppFont(fontWeight), size: msViews.textSizes.title).weight(fontWeight))
                .lineSpacing(msViews.textSizes.titleLineSpacing)
                .kerning(msViews.textSizes.titleMonoSpacing)
        } else {
            content
                .font(.custom(getAppFont(fontWeight), size: msViews.textSizes.title).weight(fontWeight))
                .lineSpacing(msViews.textSizes.titleLineSpacing)
        }
    }
}

struct MainTextModifier : ViewModifier {
    var fontWeight : Font.Weight = .medium
    
    func body(content:Content) -> some View {
        if #available(iOS 16.0, *) {
            content
                .font(.custom(getAppFont(fontWeight), size: msViews.textSizes.main).weight(fontWeight))
                .lineSpacing(msViews.textSizes.mainLineSpacing)
                .kerning(msViews.textSizes.mainMonoSpacing)
        } else {
            content
                .font(.custom(getAppFont(fontWeight), size: msViews.textSizes.main).weight(fontWeight))
                .lineSpacing(msViews.textSizes.mainLineSpacing)
        }
    }
}

struct HeaderModifier : ViewModifier {
    var fontWeight : Font.Weight = .medium
    
    func body(content:Content) -> some View {
        if #available(iOS 16.0, *) {
            content
                .font(.custom(getAppFont(fontWeight), size: msViews.textSizes.header).weight(fontWeight))
                .lineSpacing(msViews.textSizes.headerLineSpacing)
                .kerning(msViews.textSizes.headerMonoSpacing)
        } else {
            content
                .font(.custom(getAppFont(fontWeight), size: msViews.textSizes.header).weight(fontWeight))
                .lineSpacing(msViews.textSizes.headerLineSpacing)
        }
    }
}


struct PriceModifier : ViewModifier {
    var fontWeight : Font.Weight = .medium
    
    func body(content:Content) -> some View {
        if #available(iOS 16.0, *) {
            content
                .font(.custom(getAppFont(fontWeight), size: msViews.textSizes.price).weight(fontWeight))
                .lineSpacing(msViews.textSizes.priceLineSpacing)
                .kerning(msViews.textSizes.priceMonoSpacing)
        } else {
            content
                .font(.custom(getAppFont(fontWeight), size: msViews.textSizes.price).weight(fontWeight))
                .lineSpacing(msViews.textSizes.priceLineSpacing)
        }
    }
}

struct ButtonTitleModifier : ViewModifier {
    var fontWeight : Font.Weight = .medium
    
    func body(content:Content) -> some View {
        if #available(iOS 16.0, *) {
            content
                .font(.custom(getAppFont(fontWeight), size: msViews.textSizes.button).weight(fontWeight))
                .lineSpacing(msViews.textSizes.buttonLineSpacing)
                .kerning(msViews.textSizes.buttonMonoSpacing)
        } else {
            content
                .font(.custom(getAppFont(fontWeight), size: msViews.textSizes.button).weight(fontWeight))
                .lineSpacing(msViews.textSizes.buttonLineSpacing)
        }
    }
}

struct PlaceHolderTitleModifier : ViewModifier {
    var fontWeight : Font.Weight = .regular
    func body(content:Content) -> some View {
        if #available(iOS 16.0, *) {
            content
                .font(.custom(getAppFont(fontWeight), size: msViews.textSizes.placeHolder).weight(fontWeight))
                .lineSpacing(msViews.textSizes.placeHolderLineSpacing)
                .kerning(msViews.textSizes.placeHolderMonoSpacing)
        } else {
            content
                .font(.custom(getAppFont(fontWeight), size: msViews.textSizes.placeHolder).weight(fontWeight))
                .lineSpacing(msViews.textSizes.placeHolderLineSpacing)
        }
    }
}


struct TabBarTitleModifier : ViewModifier {
    var fontWeight : Font.Weight = .regular
    
    func body(content:Content) -> some View {
        if #available(iOS 16.0, *) {
            content
                .font(.custom(getAppFont(fontWeight), size: msViews.textSizes.tabBar).weight(fontWeight))
                .lineSpacing(msViews.textSizes.tabBarLineSpacing)
                .kerning(msViews.textSizes.tabBarMonoSpacing)
        } else {
            content
                .font(.custom(getAppFont(fontWeight), size: msViews.textSizes.tabBar).weight(fontWeight))
                .lineSpacing(msViews.textSizes.tabBarLineSpacing)
        }
    }
}

struct CustomTitleModifier : ViewModifier {
    var textSize : CGFloat = 14
    var lineSpacing : CGFloat = 20
    var monoSpacing : CGFloat = 0
    var fontWeight : Font.Weight = .bold
    
    func body(content:Content) -> some View {
        if #available(iOS 16.0, *) {
            content
                .font(.custom(getAppFont(fontWeight), size: textSize).weight(fontWeight))
                .lineSpacing(lineSpacing)
                .kerning(monoSpacing / 100)
        } else {
            content
                .font(.custom(getAppFont(fontWeight), size: textSize).weight(fontWeight))
                .lineSpacing(lineSpacing)
        }
    }
}

public extension View {
    @ViewBuilder func textStyle(_ style:CustomTextStyle , size:CGFloat = 14 , lineSpacing : CGFloat = 20 , monoSpacing : CGFloat = 0 , fontWeight : Font.Weight? = nil) -> some View{
        switch style {
        case .title:
            if(fontWeight != nil) {
                modifier(TitleModifier(fontWeight: fontWeight!))
            } else {
                modifier(TitleModifier())
            }
        case .price:
            if(fontWeight != nil) {
                modifier(PriceModifier(fontWeight: fontWeight!))
            } else {
                modifier(PriceModifier())
            }
        case .header:
            if(fontWeight != nil) {
                modifier(HeaderModifier(fontWeight: fontWeight!))
            } else {
                modifier(HeaderModifier())
            }
            
        case .button:
            if(fontWeight != nil) {
                modifier(ButtonTitleModifier(fontWeight: fontWeight!))
            } else {
                modifier(ButtonTitleModifier())
            }
        case .placeHolder:
            if(fontWeight != nil) {
                modifier(PlaceHolderTitleModifier(fontWeight: fontWeight!))
            } else {
                modifier(PlaceHolderTitleModifier())
            }
        case .tabBar:
            if(fontWeight != nil) {
                modifier(TabBarTitleModifier(fontWeight: fontWeight!))
            } else {
                modifier(TabBarTitleModifier())
            }
        case .custom:
            if(fontWeight != nil) {
                if #available(iOS 16.0, *) {
                    modifier(CustomTitleModifier(textSize: size, lineSpacing: lineSpacing, monoSpacing: monoSpacing , fontWeight: fontWeight!))
                }
            } else {
                modifier(CustomTitleModifier(textSize: size, lineSpacing: lineSpacing, monoSpacing: monoSpacing))
            }
        default:
            if(fontWeight != nil) {
                modifier(MainTextModifier(fontWeight: fontWeight!))
            } else {
                modifier(MainTextModifier())
            }
        }
    }
}

public enum CustomTextStyle {
    case title
    case header
    case button
    case main
    case price
    case placeHolder
    case tabBar
    case custom
}
