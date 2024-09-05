//
//  File.swift
//  
//
//  Created by Corptia 02 on 16/08/2022.
//

import Foundation
import L10n_swift
import NaturalLanguage
import SwiftUI

public class LangRelatedMethods{
    public static let shared = LangRelatedMethods.init()
    
    public func isArabic() -> Bool {
        return L10n.shared.language == LangEnum.Arabic.rawValue
        //        return userLogInData.user.locale == LangEnum.Arabic
    }
    
    public func isArabic(_ text:String) -> Bool {
        let recognizer = NLLanguageRecognizer()
        recognizer.processString(text)
        guard let languageCode = recognizer.dominantLanguage?.rawValue else {
            return false
        }
        
        let detectedLanguage = Locale.current.localizedString(forIdentifier: languageCode)
        return detectedLanguage! == "Arabic"
    }
    
    public func replaceArabicNumbers(number:String) -> String{
        var returnedNum = number
        
        if (returnedNum.contains("٠")) {
            returnedNum = returnedNum.replacingOccurrences(of: "٠", with: "0")
        }
        if (returnedNum.contains("١")) {
            returnedNum = returnedNum.replacingOccurrences(of: "١", with: "1")
        }
        if (returnedNum.contains("٢")) {
            returnedNum = returnedNum.replacingOccurrences(of: "٢", with: "2")
        }
        if (returnedNum.contains("٣")) {
            returnedNum = returnedNum.replacingOccurrences(of: "٣", with: "3")
        }
        if (returnedNum.contains("٤")) {
            returnedNum = returnedNum.replacingOccurrences(of: "٤", with: "4")
        }
        if (returnedNum.contains("٥")) {
            returnedNum = returnedNum.replacingOccurrences(of: "٥", with: "5")
        }
        if (returnedNum.contains("٦")) {
            returnedNum = returnedNum.replacingOccurrences(of: "٦", with: "6")
        }
        if (returnedNum.contains("٧")) {
            returnedNum = returnedNum.replacingOccurrences(of: "٧", with: "7")
        }
        if (returnedNum.contains("٨")) {
            returnedNum = returnedNum.replacingOccurrences(of: "٨", with: "8")
        }
        if (returnedNum.contains("٩")) {
            returnedNum = returnedNum.replacingOccurrences(of: "٩", with: "9")
        }
        msViews.printing.tagPrint("returnedNum::: \(returnedNum)")
        return returnedNum
    }
    
    public func changeToArabic(){
        L10n.shared.language = LangEnum.Arabic.rawValue
        SharedPrefHelper.shared.setSharedPref(key: .lang, value: LangEnum.Arabic.rawValue as AnyObject)
    }
    
    public func changeToEnglish(){
        L10n.shared.language = LangEnum.English.rawValue
        SharedPrefHelper.shared.setSharedPref(key: .lang, value: LangEnum.English.rawValue as AnyObject)
    }
    
    public func changeLang(_ changeTo:LangEnum){
        if(changeTo == .Arabic) {
            changeToArabic()
        } else {
            changeToEnglish()
        }
    }
    
    public func getDefaultLang()-> String {
        var deviceLanguage = "ar"
        if #available(iOS 16, *) {
            deviceLanguage = Locale.current.language.languageCode?.identifier ?? "en"
        } else {
            deviceLanguage = Locale.current.languageCode ?? "en"
        }
        return deviceLanguage
    }
    
    public func setDefaultLocale(){
        let defaultLang = getDefaultLang()
        print("LANG CHECK" , SharedPrefHelper.shared.getSharedPref(key: .notFirstTime))
        print("LANG CHECK SAVED LANG" , SharedPrefHelper.shared.getSharedPref(key: .lang))
        if let notFirstTime = SharedPrefHelper.shared.getSharedPref(key: .notFirstTime) as? Bool  , let lang = SharedPrefHelper.shared.getSharedPref(key: .lang) as? String{
            if(notFirstTime) {
                if(lang == "ar"){
                    print("LANG CHECK CHANGING TO ARABIC , ", notFirstTime)
                    changeToArabic()
                } else {
                    print("LANG CHECK CHANGING TO ENGLISH , ", notFirstTime)
                    changeToEnglish()
                }
            } else {
                if(defaultLang == "ar"){
                    print("LANG CHECK CHANGING TO ARABIC , ", notFirstTime)
                    changeToArabic()
                } else {
                    print("LANG CHECK CHANGING TO ENGLISH , ", notFirstTime)
                    changeToEnglish()
                }
            }
            SharedPrefHelper.shared.setSharedPref(key: .notFirstTime, value: true as AnyObject)
        } else {
            if(defaultLang == "ar"){
                changeToArabic()
            } else {
                changeToEnglish()
            }
            SharedPrefHelper.shared.setSharedPref(key: .notFirstTime, value: true as AnyObject)
        }
        
        print("LANG CHECK" , L10n.shared.language)
    }
}

public enum LangEnum: String {
    case Arabic = "ar"
    case English = "en"
}

struct LangModifier : ViewModifier {
    
    func body(content:Content) -> some View {
        content
            .environment(\.layoutDirection, msViews.langMethods.isArabic() ? .rightToLeft : .leftToRight)
    }
}

extension View {
    @ViewBuilder
    public func langModifier()-> some View{
        modifier(LangModifier())
    }
}
