//
//  Strings.swift
//  MSViews
//
//  Created by Moha on 9/5/24.
//


import L10n_swift

public func strings(_ key:String)-> String {
    
    //TODO: create a stringFunc that returns a String , and run the following code
//    var multiLang : String = key
//    if let multiLangString = multiLangStrings.first(where: { multiLangModel in
//        return multiLangModel.en == key.rawValue
//    }) {
//        multiLang = multiLangString.en
//        return multiLang.l10n()
//    }
//
//    if(multiLang.isEmpty){
//        multiLang = key.rawValue
//    }

    return key.l10n()
}