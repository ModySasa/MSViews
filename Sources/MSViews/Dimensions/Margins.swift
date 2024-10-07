//
//  File.swift
//  
//
//  Created by Corptia 02 on 09/04/2023.
//

import Foundation
import UIKit

public struct Margins {
    public let mainMarginHorizontal : CGFloat
    
    public let mainMarginTop : CGFloat
    public let mainMarginBottom : CGFloat
    
    public let mainButtonHeight : CGFloat
    public let mainButtonWidth : CGFloat
    
    public func screenSize() -> CGRect {
        return UIScreen.main.bounds
    }
    
    public func screenWidth()-> CGFloat {
        return screenSize().width
    }
    
    public func screenHeight()-> CGFloat {
        return screenSize().height
    }
    
    public init (
        mainMarginTop : CGFloat = 35,
        mainMarginHorizontal : CGFloat = 22.5,
        mainMarginBottom : CGFloat = 35,
        mainButtonHeight : CGFloat = 56,
        mainButtonWidth : CGFloat = 200
    ){
        self.mainMarginTop = mainMarginTop
        self.mainMarginHorizontal = mainMarginHorizontal
        self.mainMarginBottom = mainMarginBottom
        self.mainButtonHeight = mainButtonHeight
        self.mainButtonWidth = mainButtonWidth
    }
}
