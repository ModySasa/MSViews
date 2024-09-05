import Foundation
import SwiftUI
//import Cosmos

public struct MSViews {
    public private(set) var text = "Hello, World!"
    public init() {
        
    }
    
    public init(_ appFont:FontNames /*, stylesFile : String = ""*/){
        setAppFontName(appFont)
        //        setStylesWithFile(stylesFile)
    }
    
    public init(_ appFont:FontNames ,_ arabicFontName:FontNames /* , stylesFile : String = ""*/){
        setAppFontName(appFont)
        setArabicAppFontName(arabicFontName)
    }
    
    
    public func addNotCountObserver(_ afterChange : @escaping ()->Void){
        let notCountListner = NotificationCountListener.init()
        notCountListner.addNotCountObserver(afterChange)
    }
    
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
        btmNavSelectedTextColor : Color  = .white,
        btmNavUnSelectedTextColor : Color  = .gray,
        circleColor : Color = Color(#colorLiteral(red: 1, green: 0.5473424196, blue: 0.1859843135, alpha: 1)),
        loadingTextColor : Color = Color(#colorLiteral(red: 1, green: 0.5473424196, blue: 0.1859843135, alpha: 1)),
        backgroundColor : Color = Color(#colorLiteral(red: 1, green: 0.8217284083, blue: 0.5928615928, alpha: 1)),
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
        viewsHelper.setAppColors(
            mainAppColor: mainAppColor,
            secondaryAppColor: secondaryAppColor,
            mainTextColor: mainTextColor,
            barTextColor: barTextColor,
            secondTextColor: secondTextColor,
            placeHolderTextColor: placeHolderTextColor,
            mainButtonTextColor: mainButtonTextColor,
            secondaryButtonTextColor: secondaryButtonTextColor,
            invertedButtonTextColor: invertedButtonTextColor,
            mainButtonColor: mainButtonColor,
            secondaryButtonColor: secondaryButtonColor,
            invertedButtonColor: invertedButtonColor,
            emptyBorderColor: emptyBorderColor,
            filledBorderColor: filledBorderColor,
            emptyColor: emptyColor,
            filledColor: filledColor,
            btmNavBackgroundColor: btmNavBackgroundColor,
            btmNavSelectedTextColor: btmNavSelectedTextColor,
            btmNavUnSelectedTextColor: btmNavUnSelectedTextColor,
            circleColor: circleColor,
            loadingTextColor: loadingTextColor,
            backgroundColor: backgroundColor,
            borderColor: borderColor,
            secondBorderColor: secondBorderColor,
            thirdBorderColor: thirdBorderColor,
            fieldBackgroundColor: fieldBackgroundColor,
            dottesColor: dottesColor,
            shadowColor: shadowColor,
            selectedRadioColor: selectedRadioColor,
            selectedCellColor: selectedCellColor,
            errorColor: errorColor
        )
    }
    
    public func setTextSizes(
        title : CGFloat = 20,
        titleLineSpacing : CGFloat = 29,
        titleMonoSpacing : CGFloat = 0,
        
        large_title : CGFloat = 24,
        large_titleLineSpacing : CGFloat = 29,
        large_titleMonoSpacing : CGFloat = 0,
        
        main : CGFloat = 14,
        mainLineSpacing : CGFloat = 20,
        mainMonoSpacing : CGFloat = 0,
        
        header : CGFloat = 18,
        headerLineSpacing : CGFloat = 26,
        headerMonoSpacing : CGFloat = 0,
        
        placeHolder : CGFloat = 14,
        placeHolderLineSpacing : CGFloat = 20,
        placeHolderMonoSpacing : CGFloat = 0,
        
        button : CGFloat = 16,
        buttonLineSpacing : CGFloat = 16,
        buttonMonoSpacing : CGFloat = 50,
        
        tabBar : CGFloat = 25,
        tabBarLineSpacing : CGFloat = 25,
        tabBarMonoSpacing : CGFloat = 0,
        
        price : CGFloat = 16,
        priceLineSpacing : CGFloat = 23,
        priceMonoSpacing : CGFloat = 0,
        
        badge : CGFloat = 14,
        badgeLineSpacing : CGFloat = 14,
        badgeMonoSpacing : CGFloat = 0,
        
        badge_small : CGFloat = 10,
        badge_smallLineSpacing : CGFloat = 14,
        badge_smallMonoSpacing : CGFloat = 0
    ){
        textSizes.setTextSizes(
            title : title,
            titleLineSpacing : titleLineSpacing,
            titleMonoSpacing : titleMonoSpacing,
            large_title : large_title,
            large_titleLineSpacing : large_titleLineSpacing,
            large_titleMonoSpacing : large_titleMonoSpacing,
            main : main,
            mainLineSpacing : mainLineSpacing,
            mainMonoSpacing : mainMonoSpacing,
            header : header,
            headerLineSpacing : headerLineSpacing,
            headerMonoSpacing : headerMonoSpacing,
            placeHolder : placeHolder,
            placeHolderLineSpacing : placeHolderLineSpacing,
            placeHolderMonoSpacing : placeHolderMonoSpacing,
            button : button,
            buttonLineSpacing : buttonLineSpacing,
            buttonMonoSpacing : buttonMonoSpacing,
            tabBar :tabBar,
            tabBarLineSpacing :tabBarLineSpacing,
            tabBarMonoSpacing :tabBarMonoSpacing,
            price : price,
            priceLineSpacing : priceLineSpacing,
            priceMonoSpacing : priceMonoSpacing,
            badge : badge,
            badgeLineSpacing : badgeLineSpacing,
            badgeMonoSpacing : badgeMonoSpacing,
            badge_small : badge_small,
            badge_smallLineSpacing : badge_smallLineSpacing,
            badge_smallMonoSpacing : badge_smallMonoSpacing
        )
    }
    
    public func setAppMargins(
        appBarHeight : CGFloat = 80,
        backBarPaddingLeading : CGFloat = 22.5,
        backBarPaddingBottom : CGFloat = 22.5,
        mainMarginTop : CGFloat = 35,
        mainMarginHorizontal : CGFloat = 22.5,
        mainMarginBottom : CGFloat = 35,
        mainButtonHeight : CGFloat = 56,
        mainButtonWidth : CGFloat = 200,
        tabBarHeight : CGFloat = 200,
        tabBarBottomPadding : CGFloat = 200,
        tabBarHorizontalPadding : CGFloat = 200
    ){
        margins.setAppMargins(
            appBarHeight: appBarHeight,
            backBarPaddingLeading: backBarPaddingLeading,
            backBarPaddingBottom: backBarPaddingBottom,
            mainMarginTop: mainMarginTop,
            mainMarginHorizontal: mainMarginHorizontal,
            mainMarginBottom: mainMarginBottom,
            mainButtonHeight: mainButtonHeight,
            mainButtonWidth: mainButtonWidth,
            tabBarHeight: tabBarHeight,
            tabBarBottomPadding: tabBarBottomPadding,
            tabBarHorizontalPadding: tabBarHorizontalPadding
        )
    }
    
//    public let networkHelper = NetworkHelper.shared
    
    public let sharedPrefHelper = SharedPrefHelper.shared
    
    //    public let stylesHelper = Styles.shared
    
//    public let dataHandling = DataHandlingMethods.shared
    
    public let fixNumbers = FixNumbers.shared
    
    public let timeMethods = TimeMethods.shared
    
    public let printing = Printing.shared
    
    public let intents = Intents.shared
    
    public let langMethods = LangRelatedMethods.shared
    
    public let viewsHelper = ViewHelpers.shared
    
    //    public let dropDownHelper = DropDownHelper.shared
    
    public let textSizes = TextSizes.shared
    
    public let margins = Margins.shared
    
    //    public let apolloHelper = ApolloHelper.shared
    
}

class NotificationCountListener{
    
    private var countChanged : (()->Void)!
    
    func addNotCountObserver(_ afterChange : @escaping ()->Void){
        countChanged = afterChange
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.addObserver(
            self, selector: #selector(onNotsCountChanged), name: .NotCount , object: nil
        )
    }
    
    @objc func onNotsCountChanged(){
        if let changed = countChanged {
            changed()
        }
    }
}
