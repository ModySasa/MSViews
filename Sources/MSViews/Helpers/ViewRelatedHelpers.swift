//
//  ViewRelatedHelpers.swift
//  Sonqor
//
//  Created by Ahmed Maher on 10/17/20.
//

import Foundation
import SwiftUI

public class ViewHelpers{
    public static let shared = ViewHelpers.init()
    
    public var mainAppColor = Color(#colorLiteral(red: 1, green: 0.5473424196, blue: 0.1859843135, alpha: 1))
    public var secondaryAppColor = Color(#colorLiteral(red: 0, green: 0.6516070366, blue: 0.5935842395, alpha: 1))
    
    //text colors
    public var mainTextColor = Color(#colorLiteral(red: 0.0862745098, green: 0.0862745098, blue: 0.1882352941, alpha: 1))
    public var barTextColor = Color(#colorLiteral(red: 0.0862745098, green: 0.0862745098, blue: 0.1882352941, alpha: 1))
    public var secondTextColor = Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
    public var placeHolderTextColor = Color(#colorLiteral(red: 0.5453153849, green: 0.5445025563, blue: 0.5965225101, alpha: 1))
    public var mainButtonTextColor : Color = .white
    public var secondaryButtonTextColor : Color = .black
    public var invertedButtonTextColor = Color(#colorLiteral(red: 1, green: 0.5473424196, blue: 0.1859843135, alpha: 1))
    
    //button colors
    public var mainButtonColor = Color(#colorLiteral(red: 1, green: 0.5473424196, blue: 0.1859843135, alpha: 1))
    public var secondaryButtonColor = Color(#colorLiteral(red: 0, green: 0.6516070366, blue: 0.5935842395, alpha: 1))
    public var invertedButtonColor : Color = .white
    
    //rating colors
    public var emptyBorderColor : Color = Color(#colorLiteral(red: 0.9871478677, green: 0.8426383138, blue: 0.7574546933, alpha: 1))
    public var filledBorderColor : Color = Color(#colorLiteral(red: 1, green: 0.7485249639, blue: 0, alpha: 1))
    public var emptyColor : Color = Color(#colorLiteral(red: 0.9871478677, green: 0.8426383138, blue: 0.7574546933, alpha: 1))
    public var filledColor : Color = Color(#colorLiteral(red: 1, green: 0.7485249639, blue: 0, alpha: 1))
    
    //bottom nav colors
    public var btmNavBackgroundColor : Color = .white
    public var btmNavSelectedTextColor  : Color = .blue
    public var btmNavUnSelectedTextColor  : Color = .gray
    
    //Loading view colors
    public var circleColor = Color(#colorLiteral(red: 1, green: 0.5473424196, blue: 0.1859843135, alpha: 1))
    public var loadingTextColor = Color(#colorLiteral(red: 1, green: 0.5473424196, blue: 0.1859843135, alpha: 1))
    
    //Views color
    public var backgroundColor = Color(#colorLiteral(red: 0.9882352941, green: 0.9450980392, blue: 0.9019607843, alpha: 1))
    public var borderColor = Color(#colorLiteral(red: 1, green: 0.5473424196, blue: 0.1859843135, alpha: 1))
    public var secondBorderColor = Color(#colorLiteral(red: 0.9254901961, green: 0.9254901961, blue: 0.9254901961, alpha: 1))
    public var thirdBorderColor = Color(#colorLiteral(red: 0.9254901961, green: 0.9254901961, blue: 0.9254901961, alpha: 1))
    public var fieldBackgroundColor : Color = .white
    public var dottesColor = Color(#colorLiteral(red: 1, green: 0.5473424196, blue: 0.1859843135, alpha: 1))
    
    public var shadowColor = Color(#colorLiteral(red: 0.5450980392, green: 0.5450980392, blue: 0.5921568627, alpha: 0.05))
    public var errorColor = Color(.red)
    
    public var selectedRadioColor = Color(#colorLiteral(red: 1, green: 0.5473424196, blue: 0.1859843135, alpha: 1))
    public var selectedCellColor = Color(#colorLiteral(red: 1, green: 0.9028659463, blue: 0.8346757293, alpha: 1))
    
    public func setAppColors(
        mainAppColor : Color = Color(#colorLiteral(red: 1, green: 0.5473424196, blue: 0.1859843135, alpha: 1)),
        secondaryAppColor : Color = Color(#colorLiteral(red: 0, green: 0.6516070366, blue: 0.5935842395, alpha: 1)),
        mainTextColor : Color = Color(#colorLiteral(red: 0.08689216524, green: 0.0845637843, blue: 0.1870593727, alpha: 1)),
        barTextColor : Color = Color(#colorLiteral(red: 0.08689216524, green: 0.0845637843, blue: 0.1870593727, alpha: 1)),
        secondTextColor : Color = Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)),
        placeHolderTextColor : Color = Color(#colorLiteral(red: 0.5453153849, green: 0.5445025563, blue: 0.5965225101, alpha: 1)),
        mainButtonTextColor : Color = .white,
        secondaryButtonTextColor  : Color = .black,
        invertedButtonTextColor : Color = Color(#colorLiteral(red: 1, green: 0.5473424196, blue: 0.1859843135, alpha: 1)),
        mainButtonColor : Color = Color(#colorLiteral(red: 1, green: 0.5473424196, blue: 0.1859843135, alpha: 1)),
        secondaryButtonColor : Color = Color(#colorLiteral(red: 0, green: 0.6516070366, blue: 0.5935842395, alpha: 1)),
        invertedButtonColor : Color = .white,
        emptyBorderColor :Color = .gray,
        filledBorderColor : Color = .yellow,
        emptyColor : Color = .gray,
        filledColor : Color = .yellow,
        btmNavBackgroundColor : Color = .white,
        btmNavSelectedTextColor : Color  = .blue,
        btmNavUnSelectedTextColor : Color  = .gray,
        circleColor : Color = Color(#colorLiteral(red: 1, green: 0.5473424196, blue: 0.1859843135, alpha: 1)),
        loadingTextColor : Color = Color(#colorLiteral(red: 1, green: 0.5473424196, blue: 0.1859843135, alpha: 1)),
        backgroundColor : Color = Color(#colorLiteral(red: 0.9976039529, green: 0.9432238936, blue: 0.8966402411, alpha: 1)),
        borderColor : Color = Color(#colorLiteral(red: 1, green: 0.5473424196, blue: 0.1859843135, alpha: 1)),
        secondBorderColor : Color = Color(#colorLiteral(red: 1, green: 0.5473424196, blue: 0.1859843135, alpha: 1)),
        thirdBorderColor : Color = Color(#colorLiteral(red: 1, green: 0.5473424196, blue: 0.1859843135, alpha: 1)),
        fieldBackgroundColor : Color = .white,
        dottesColor : Color = Color(#colorLiteral(red: 1, green: 0.5473424196, blue: 0.1859843135, alpha: 1)),
        shadowColor : Color = Color(#colorLiteral(red: 0.5450980392, green: 0.5450980392, blue: 0.5921568627, alpha: 0.05)),
        selectedRadioColor : Color = Color(#colorLiteral(red: 1, green: 0.5473424196, blue: 0.1859843135, alpha: 1)),
        selectedCellColor : Color = Color(#colorLiteral(red: 1, green: 0.9028659463, blue: 0.8346757293, alpha: 1)),
        errorColor : Color = Color(.red)
    ){
        self.mainAppColor = mainAppColor
        self.secondaryAppColor = secondaryAppColor
        self.mainTextColor = mainTextColor
        self.barTextColor = barTextColor
        self.secondTextColor = secondTextColor
        self.placeHolderTextColor = placeHolderTextColor
        self.mainButtonTextColor = mainButtonTextColor
        self.secondaryButtonTextColor = secondaryButtonTextColor
        self.invertedButtonTextColor = invertedButtonTextColor
        self.mainButtonColor = mainButtonColor
        self.secondaryButtonColor = secondaryButtonColor
        self.invertedButtonColor = invertedButtonColor
        self.emptyBorderColor = emptyBorderColor
        self.filledBorderColor = filledBorderColor
        self.emptyColor = emptyColor
        self.filledColor = filledColor
        self.btmNavBackgroundColor = btmNavBackgroundColor
        self.btmNavSelectedTextColor = btmNavSelectedTextColor
        self.btmNavUnSelectedTextColor = btmNavUnSelectedTextColor
        self.circleColor = circleColor
        self.loadingTextColor = loadingTextColor
        self.backgroundColor = backgroundColor
        self.borderColor = borderColor
        self.secondBorderColor = secondBorderColor
        self.thirdBorderColor = thirdBorderColor
        self.fieldBackgroundColor = fieldBackgroundColor
        self.dottesColor = dottesColor
        self.shadowColor = shadowColor
        self.selectedRadioColor = selectedRadioColor
        self.selectedCellColor = selectedCellColor
        self.errorColor = errorColor
    }
    
    public func screenSize() -> CGRect {
        return UIScreen.main.bounds
    }
    
    public func screenWidth()-> CGFloat {
        return screenSize().width
    }
    
    public func screenHeight()-> CGFloat {
        return screenSize().height
    }
    
//    public func loadingCircle(x:CGFloat , y : CGFloat) ->  NVActivityIndicatorView {
//        return NVActivityIndicatorView.init(frame: CGRect(x: x, y: y, width: CGFloat.init(50), height: CGFloat.init(50)), type: .circleStrokeSpin , color: UIColor.init(cgColor: mainButtonColor.cgColor ?? UIColor.white.cgColor) )
//    }
    
}
