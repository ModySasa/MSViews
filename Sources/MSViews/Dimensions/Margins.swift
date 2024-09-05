//
//  File.swift
//  
//
//  Created by Corptia 02 on 09/04/2023.
//

import Foundation
import UIKit

public class Margins {
    
    public static let shared = Margins.init()
    public var appBarHeight : CGFloat = 80
    public var backBarPaddingLeading : CGFloat = 22.5
    public var backBarPaddingBottom : CGFloat = 22.5
    public var mainMarginHorizontal : CGFloat = 22.5
    
    public var mainMarginTop : CGFloat = 35
    public var mainMarginBottom : CGFloat = 35
    
    public var mainButtonHeight : CGFloat = 56
    public var mainButtonWidth : CGFloat = 200
    
    public var tabBarHeight : CGFloat = 100
    public var tabBarBottomPadding : CGFloat = 10
    public var tabBarHorizontalPadding : CGFloat = 10
    
    public func screenSize() -> CGRect {
        return UIScreen.main.bounds
    }
    
    public func screenWidth()-> CGFloat {
        return screenSize().width
    }
    
    public func screenHeight()-> CGFloat {
        return screenSize().height
    }
    
    public func setAppMargins (
        appBarHeight : CGFloat = 80,
        backBarPaddingLeading : CGFloat = 22.5,
        backBarPaddingBottom : CGFloat = 22.5,
        mainMarginTop : CGFloat = 35,
        mainMarginHorizontal : CGFloat = 22.5,
        mainMarginBottom : CGFloat = 35,
        mainButtonHeight : CGFloat = 56,
        mainButtonWidth : CGFloat = 200,
        tabBarHeight : CGFloat = 100,
        tabBarBottomPadding : CGFloat = 10,
        tabBarHorizontalPadding : CGFloat = 10
    ){
        self.appBarHeight = appBarHeight
        self.backBarPaddingLeading = backBarPaddingLeading
        self.backBarPaddingBottom = backBarPaddingBottom
        self.mainMarginTop = mainMarginTop
        self.mainMarginHorizontal = mainMarginHorizontal
        self.mainMarginBottom = mainMarginBottom
        self.mainButtonHeight = mainButtonHeight
        self.mainButtonWidth = mainButtonWidth
        self.tabBarHeight = tabBarHeight
        self.tabBarBottomPadding = tabBarBottomPadding
        self.tabBarHorizontalPadding = tabBarHorizontalPadding
    }
    
}
