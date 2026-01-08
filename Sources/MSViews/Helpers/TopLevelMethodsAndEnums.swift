//
//  TopLevelConstants.swift
//  Sonqor
//
//  Created by Ahmed Maher on 10/17/20.
//

import Foundation
import UIKit
import SwiftUI

//MARK: Methods
public func getDeviceId() -> String? {
    guard let deviceID = UIDevice.current.identifierForVendor?.uuidString else {
        return nil
    }
    return deviceID
}

public func printAppFonts(){
//    dump(UIFont.familyNames)
    for family in UIFont.familyNames {
        print("\(family)")

        for name in UIFont.fontNames(forFamilyName: family) {
            print("   \(name)")
        }
    }
}

public func getAppFont(_ fontWeight : Font.Weight)->String {
    if MSLanguage.isArabic {
        checkFonts(appArabicFontName , fontWeight: fontWeight)
    } else {
        checkFonts(appFontName , fontWeight: fontWeight)
    }
}

func checkFonts(_ font : String , fontWeight : Font.Weight) -> String {
    if(
        font == FontNames.gilroy.rawValue
        || font == FontNames.crimsonText.rawValue
        || font == FontNames.inter.rawValue
        || font == FontNames.instrumentSans.rawValue
        || font == FontNames.instrumentSansCondensed.rawValue
        || font == FontNames.helveticaNeue.rawValue
        || font == FontNames.ibmPlexSansArabic.rawValue
    ) {
        var namee = font
        switch fontWeight {
        case .bold:
            namee = "\(font)-Bold"
            break
        case .heavy:
            namee = "\(font)-Heavy"
            break
        case .medium:
            namee = "\(font)-Medium"
            break
        case .regular:
            namee = font == FontNames.helveticaNeue.rawValue ? "\(font)-Medium" : "\(font)-Regular"
            break
        case .light:
            namee = "\(font)-Light"
            break
        case .semibold:
            namee = font == FontNames.inter.rawValue ? "\(font)-SemiBold" : font == FontNames.helveticaNeue.rawValue ? "\(font)-Medium" : "\(font)-Semibold"
            break
        default:
            namee = font == FontNames.helveticaNeue.rawValue ? "\(font)-Medium" : "\(font)-Regular"
        }
        return namee
    } else {
        return font
    }
}

//func decodeMessage(_ view:UIView){
//    //        decodeMessage(self.view)
//    let prev = "\u{062a}\u{0645}\u{062a} \u{0627}\u{0644}\u{0639}\u{0645}\u{0644}\u{064a}\u{0629} \u{0628}\u{0646}\u{062c}\u{0627}\u{062d}"
//    //    "\u{0628}\u{0631}\u{062c}\u{0627}\u{0621} \u{062a}\u{0633}\u{062c}\u{064a}\u{0644} \u{0627}\u{0644}\u{062f}\u{062e}\u{0648}\u{0644} \u{0623}\u{0648}\u{0644}\u{0627}"
//    _ = prev.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
//    showToast(message: prev, mainView: view, type: .info)
//}
//
//func printArabic(){
//    let prev = "\u{0628}\u{0631}\u{062c}\u{0627}\u{0621} \u{062a}\u{0633}\u{062c}\u{064a}\u{0644} \u{0627}\u{0644}\u{062f}\u{062e}\u{0648}\u{0644} \u{0623}\u{0648}\u{0644}\u{0627}"
//    let urlWithArabicChars = prev.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
//    tagPrint(prev)
//}
//

public func yes()->Bool {
    return true
}

public func no()->Bool {
    return false
}

//MARK: ENUMS
public enum SearchType : String {
    case asc = "ASC"
    case desc = "DESC"
}


public enum MSLanguage {
    public static var isArabicOverride: (() -> Bool)?
    
    public static func isArabicFallback() -> Bool {
        
        return msViews.langMethods.isArabic()
    }

    public static var isArabic: Bool {
        isArabicOverride?() ?? isArabicFallback()
    }
}
