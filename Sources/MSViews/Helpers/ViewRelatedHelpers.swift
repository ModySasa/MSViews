//
//  ViewRelatedHelpers.swift
//  Sonqor
//
//  Created by Ahmed Maher on 10/17/20.
//

import Foundation
import SwiftUI

public struct ViewHelpers{
    public let appColors : AppColors

    public var mainAppColor : Color { appColors.mainAppColor}
    public var secondaryAppColor : Color { appColors.secondaryAppColor}
    public var mainTextColor : Color { appColors.mainTextColor}
    public var secondTextColor : Color { appColors.secondTextColor}
    public var placeHolderTextColor : Color { appColors.placeHolderTextColor}
    public var mainButtonTextColor : Color { appColors.mainButtonTextColor}
    public var secondaryButtonTextColor : Color { appColors.secondaryButtonTextColor}
    public var invertedButtonTextColor : Color { appColors.invertedButtonTextColor}
    public var mainButtonColor : Color { appColors.mainButtonColor}
    public var secondaryButtonColor : Color { appColors.secondaryButtonColor}
    public var invertedButtonColor : Color { appColors.invertedButtonColor}
    public var emptyBorderColor : Color { appColors.emptyBorderColor}
    public var filledBorderColor : Color { appColors.filledBorderColor}
    public var emptyColor : Color { appColors.emptyColor}
    public var filledColor : Color { appColors.filledColor}
    public var circleColor : Color { appColors.circleColor}
    public var loadingTextColor : Color { appColors.loadingTextColor}
    public var backgroundColor : Color { appColors.backgroundColor}
    public var borderColor : Color { appColors.borderColor}
    public var secondBorderColor : Color { appColors.secondBorderColor}
    public var thirdBorderColor : Color { appColors.thirdBorderColor}
    public var fieldBackgroundColor : Color { appColors.fieldBackgroundColor}
    public var dottesColor : Color { appColors.dottesColor}
    public var shadowColor : Color { appColors.shadowColor}
    public var errorColor : Color { appColors.errorColor}
    public var selectedRadioColor : Color { appColors.selectedRadioColor}
    public var selectedCellColor : Color { appColors.selectedCellColor}
    
    public init(
        appColors: AppColors
    ){
        self.appColors = appColors
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
    
}

public struct AppColors {
    public let mainAppColor : Color
    public let secondaryAppColor : Color
    
    //text colors
    public let mainTextColor : Color
    public let secondTextColor : Color
    public let placeHolderTextColor : Color
    public let mainButtonTextColor : Color
    public let secondaryButtonTextColor : Color
    public let invertedButtonTextColor : Color
    
    //button colors
    public let mainButtonColor : Color
    public let secondaryButtonColor : Color
    public let invertedButtonColor : Color
    
    //rating colors
    public let emptyBorderColor : Color
    public let filledBorderColor : Color
    public let emptyColor : Color
    public let filledColor : Color
    
    //Loading view colors
    public let circleColor : Color
    public let loadingTextColor : Color
    
    //Views color
    public let backgroundColor : Color
    public let borderColor : Color
    public let secondBorderColor : Color
    public let thirdBorderColor : Color
    public let fieldBackgroundColor : Color
    public let dottesColor : Color
    
    public let shadowColor : Color
    public let errorColor : Color
    
    public let selectedRadioColor : Color
    public let selectedCellColor : Color
    
    
    public init(
        mainAppColor : Color = Color(#colorLiteral(red: 1, green: 0.5473424196, blue: 0.1859843135, alpha: 1)),
        secondaryAppColor : Color = Color(#colorLiteral(red: 0, green: 0.6516070366, blue: 0.5935842395, alpha: 1)),
        mainTextColor : Color = Color(#colorLiteral(red: 0.08689216524, green: 0.0845637843, blue: 0.1870593727, alpha: 1)),
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
    ) {
        self.mainAppColor = mainAppColor
        self.secondaryAppColor = secondaryAppColor
        self.mainTextColor = mainTextColor
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
}
