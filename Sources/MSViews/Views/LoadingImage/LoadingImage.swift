//
//  SwiftUIView.swift
//  
//
//  Created by Mohamed safwat on 27/11/2023.
//

import SwiftUI

public struct LoadingImage<Mod:ViewModifier , PlaceMod:ViewModifier>: View {
    public var image : String
    public var placeHolder : String
    public var placeHolderColor : Color
    public var loadingColor : Color
    public var modifier : Mod
    public var placeHolderMod : PlaceMod?
    
    public init(
        image:String
        , placeHolder:String
        , placeHolderColor: Color  = Color.white.opacity(1)
        , loadingColor : Color = msViews.viewsHelper.mainAppColor
        , modifier : Mod
        , placeHolderMod : PlaceMod? = nil
    ) {
        self.image = image
        self.placeHolder = placeHolder
        self.placeHolderColor = placeHolderColor
        self.loadingColor = loadingColor
        self.modifier = modifier
        self.placeHolderMod = placeHolderMod
    }
    
    public var body: some View {
        img
    }
    
    @ViewBuilder
    var img : some View {
        if (!image.isEmpty && image.starts(with: "http")) {
            AsyncImage(url: URL(string: image), scale: 1) { img in
                if let image = img.image {
                    // Display the loaded image
                    image
                        .resizable()
                        .modifier(modifier)
                } else if img.error != nil {
                    // Display a placeholder when loading failed
                    Rectangle()
                        .overlay {
                            if let placeHolderMod {
                                CustomImage(placeHolder)
                                    .resizable()
                                    .scaledToFit()
                                    .padding(10)
                                    .modifier(placeHolderMod)
                            } else {
                                CustomImage(placeHolder)
                                    .resizable()
                                    .scaledToFit()
                                    .padding(10)
                            }
                        }
                        .foregroundColor(placeHolderColor)
                        .modifier(modifier)
                } else {
                    // Display a placeholder while loading
                    ProgressView()
                        .tint(loadingColor)
                        .progressViewStyle(.circular)
                        .modifier(modifier)
                }
            }
        } else {
            Rectangle()
                .overlay {
                    if let placeHolderMod {
                        CustomImage(placeHolder)
                            .resizable()
                            .scaledToFit()
                            .padding(10)
                            .modifier(placeHolderMod)
                    } else {
                        CustomImage(placeHolder)
                            .resizable()
                            .scaledToFit()
                            .padding(10)
                    }
                }
                .foregroundColor(placeHolderColor)
                .modifier(modifier)
        }
    }
}

//struct LoadingImage_Previews: PreviewProvider {
//    static var previews: some View {
//        LoadingImage(image: <#String#>, placeHolder: <#String#>, loadingColor: <#Color#>, modifier: <#_#>)
//    }
//}
