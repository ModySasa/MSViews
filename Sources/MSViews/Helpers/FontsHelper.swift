//
//  FontsHelper.swift
//  
//
//  Created by Mohamed safwat on 09/10/2023.
//

import Foundation

public var appFontName = "Arial"
public var appArabicFontName = "Cairo"
public enum FontNames:String {
    case arial = "Arial"
    case cairo = "Cairo"
    case poppins = "Poppins"
    case graphik = "Graphik"
    case segoeUI = "Segoe UI"
    case helvetica = "Helvetica"
    case gilroy = "Gilroy"
    case readexPro = "Readex Pro"
    case somarSans = "Somar Sans"
    case openSans = "Open Sans"
    case raleway = "Raleway"
    case robotoSlab = "Roboto Slab"
    case gabarito = "Gabarito"
    case chivo = "Chivo"
    case comme = "Comme"
    case tajawal = "Tajawal"
    case crimsonText = "Crimsontext"
    case inter = "Inter28pt"
}

public func setAppFontName(_ name:FontNames){
    appFontName = name.rawValue
    setArabicAppFontName(name)
}

public func setArabicAppFontName(_ name:FontNames){
    appArabicFontName = name.rawValue
}
