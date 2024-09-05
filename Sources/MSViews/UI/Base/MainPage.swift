//
//  SwiftUIView.swift
//  
//
//  Created by Corptia 02 on 06/04/2023.
//

import SwiftUI

public struct MainPage<Content : View>: View {
    var content : Content
    var withScroll : Bool = true
    var shouldHasBottomPadding : Bool = true
    var shouldHasHorizontalPadding : Bool = true
    var backgroundColor : Color = msViews.viewsHelper.backgroundColor
    @Binding var toast : Toast
    var onRefresh : (()->Void)! = nil
    
    public init(
        toast:Binding<Toast>,
        withScroll:Bool = true ,
        shouldHasBottomPadding : Bool = true,
        shouldHasHorizontalPadding : Bool = true,
        backgroundColor:Color = msViews.viewsHelper.backgroundColor ,
        @ViewBuilder content: () -> Content ,
        onRefresh : (()->Void)! = nil
    ) {
        self.content = content()
        self.withScroll = withScroll
        self.backgroundColor = backgroundColor
        self._toast = toast
        self.onRefresh = onRefresh
        self.shouldHasBottomPadding = shouldHasBottomPadding
        self.shouldHasHorizontalPadding = shouldHasHorizontalPadding
    }
    
    public var body: some View {
        ZStack(alignment: .top){
            backgroundColor
                .ignoresSafeArea()
            if(withScroll)  {
                if(onRefresh != nil) {
                    ScrollView (showsIndicators: false){
                        VStack{
                            content
                            Spacer()
                        }
                    }
                    .refreshable {
                        if let refresh = onRefresh {
                            refresh()
                        }
                    }
                    .padding(.horizontal, shouldHasHorizontalPadding ? msViews.margins.mainMarginHorizontal : 0)
                    .padding(.bottom, shouldHasBottomPadding ? msViews.margins.mainMarginBottom : 0)
                } else {
                    ScrollView (showsIndicators: false){
                        VStack{
                            content
                            Spacer()
                        }
                    }
                    .padding(.horizontal, shouldHasHorizontalPadding ? msViews.margins.mainMarginHorizontal : 0)
                    .padding(.bottom, shouldHasBottomPadding ? msViews.margins.mainMarginBottom : 0)
                }
            } else {
                VStack{
                    content
                    Spacer()
                }
                .padding(.horizontal, shouldHasHorizontalPadding ? msViews.margins.mainMarginHorizontal : 0)
                .padding(.bottom, shouldHasBottomPadding ? msViews.margins.mainMarginBottom : 0)
            }
            if(!toast.message.isEmpty){
                ToastView(toast: $toast)
            }
        }
    }
}

struct MainPageHelper : View{
    @State var toast : Toast = .init(
        message: "Show the toast",
        type: .info
    )
    
    var body: some View {
        MainPage(toast: $toast) {
            Text("Hello, World!")
        }
    }
}
struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPageHelper()
    }
}
