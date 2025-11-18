//
//  LanguageManager.swift
//  MSViews
//
//  Created by Moha on 10/30/25.
//

import SwiftUI

@available(iOS 17.0, *)
@Observable
public class LanguageManager {
    public var locale: Locale
    public var layoutDirection: LayoutDirection

    public init() {
        let savedLanguage = UserDefaults.standard.string(forKey: "selectedLanguage") ?? "en"
        self.locale = Locale(identifier: savedLanguage)
        self.layoutDirection = (savedLanguage == "ar") ? .rightToLeft : .leftToRight
    }
    
    public func changeLanguage(to language: String) {
        UserDefaults.standard.set(language, forKey: "selectedLanguage")
        UserDefaults.standard.synchronize()
        Bundle.localizedBundle = Bundle.setLanguage(language)
        locale = Locale(identifier: language)
        layoutDirection = (language == "ar") ? .rightToLeft : .leftToRight
        print("~~~~~~~~~~~~~~~~~layoutDirection: ", layoutDirection)
        MSLanguage.isArabicOverride = { language == "ar" }
    }
}

public class ObservableLanguageManager : ObservableObject {
    @Published public var locale: Locale
    @Published public var layoutDirection: LayoutDirection

    public init() {
        let savedLanguage = UserDefaults.standard.string(forKey: "selectedLanguage") ?? "en"
        self.locale = Locale(identifier: savedLanguage)
        self.layoutDirection = (savedLanguage == "ar") ? .rightToLeft : .leftToRight
    }
    
    public func changeLanguage(to language: String) {
        UserDefaults.standard.set(language, forKey: "selectedLanguage")
        UserDefaults.standard.synchronize()
        Bundle.localizedBundle = Bundle.setLanguage(language)
        locale = Locale(identifier: language)
        layoutDirection = (language == "ar") ? .rightToLeft : .leftToRight
        print("~~~~~~~~~~~~~~~~~layoutDirection: ", layoutDirection)
        MSLanguage.isArabicOverride = { language == "ar" }
    }
}

private var bundleKey: UInt8 = 0

public extension Bundle {
    static var localizedBundle: Bundle = {
        let language = UserDefaults.standard.string(forKey: "selectedLanguage") ?? "en"
        return Bundle.setLanguage(language)
    }()

    static func setLanguage(_ language: String) -> Bundle {
        guard let path = Bundle.main.path(forResource: language, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return Bundle.main
        }
        
        objc_setAssociatedObject(Bundle.main, &bundleKey, bundle, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return bundle
    }
    
    static func localizedString(forKey key: String, value: String? = nil, table: String? = nil) -> String {
        let bundle = objc_getAssociatedObject(Bundle.main, &bundleKey) as? Bundle ?? Bundle.main
        return bundle.localizedString(forKey: key, value: value, table: table)
    }
}

public extension LocalizedStringKey {
    func localizedString() -> String {
        let mirror = Mirror(reflecting: self)
        if let key = mirror.children.first(where: { $0.label == "key" })?.value as? String {
            return NSLocalizedString(key , bundle: .localizedBundle, comment: "")
        }
        return ""
    }
}

public extension String {
    func localizedString() -> String {
        LocalizedStringKey.init(self).localizedString()
    }
}
