import Foundation
import SwiftUI
//import Cosmos

public struct MSViews {
    
    private init(_ appFont:FontNames ,_ arabicFontName:FontNames? = nil  , appColors : AppColors , textSizes : TextSizes , margins : Margins){
        setAppFontName(appFont)
        if let arabicFontName = arabicFontName{
            setArabicAppFontName(arabicFontName)
        }
        self.viewsHelper = .init(appColors:appColors)
        self.textSizes = textSizes
        self.margins = margins
    }
    
    // Static property to hold the singleton instance
    private static var instance: MSViews?
    
    public static func initialize(_ appFont:FontNames ,_ arabicFontName:FontNames? = nil  , appColors : AppColors , textSizes : TextSizes , margins : Margins) {
        guard instance == nil else {
            fatalError("MSViews has already been initialized.")
//            return
        }
        instance = .init(appFont, arabicFontName, appColors: appColors, textSizes: textSizes, margins: margins)
    }
    
    public static var shared: MSViews {
        guard let instance = instance else {
            fatalError("MSViews has not been initialized. Call initialize(colors:) first.")
        }
        return instance
    }
    
    public func addNotCountObserver(_ afterChange : @escaping ()->Void){
        let notCountListner = NotificationCountListener.init()
        notCountListner.addNotCountObserver(afterChange)
    }
    
    public let sharedPrefHelper = SharedPrefHelper.shared
    
    public let fixNumbers = FixNumbers.shared
    
    public let timeMethods = TimeMethods.shared
    
    public let printing = Printing.shared
    
    public let intents = Intents.shared
    
    public let langMethods = LangRelatedMethods.shared
    
    public let viewsHelper : ViewHelpers
    
    public let textSizes : TextSizes
    
    public let margins : Margins
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
