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

func getAppFont(_ fontWeight : Font.Weight)->String {
    if(msViews.langMethods.isArabic()) {
        return appArabicFontName
    } else {
        if(
            appFontName == FontNames.gilroy.rawValue
            || appFontName == FontNames.crimsonText.rawValue
            || appFontName == FontNames.inter.rawValue
        ) {
            var namee = appFontName
            switch fontWeight {
            case .bold:
                namee = "\(appFontName)-Bold"
                break
            case .heavy:
                namee = "\(appFontName)-Heavy"
                break
            case .medium:
                namee = "\(appFontName)-Medium"
                break
            case .regular:
                namee = "\(appFontName)-Regular"
                break
            case .light:
                namee = "\(appFontName)-Light"
                break
            case .semibold:
                namee = appFontName == FontNames.inter.rawValue ? "\(appFontName)-SemiBold" : "\(appFontName)-Semibold"
                break
            default:
                namee = "\(appFontName)-Regular"
            }
            return namee
        } else {
            return appFontName
        }
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
