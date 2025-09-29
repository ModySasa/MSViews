//
//  File.swift
//  
//
//  Created by Mohamed safwat on 09/12/2023.
//

import Foundation
import UIKit

public extension UIFont {
    var bold: UIFont { return withWeight(.bold) }
    var heavy: UIFont { return withWeight(.heavy) }
    var regular: UIFont { return withWeight(.regular) }
    var medium: UIFont { return withWeight(.medium) }
    var semiBold: UIFont { return withWeight(.semibold) }
    var light: UIFont { return withWeight(.light) }
    
    private func withWeight(_ weight: UIFont.Weight) -> UIFont {
        
        var attributes = fontDescriptor.fontAttributes
        var traits = (attributes[.traits] as? [UIFontDescriptor.TraitKey: Any]) ?? [:]
        
        traits[.weight] = weight
        attributes[.name] = MSLanguage.isArabic ? appArabicFontName : appFontName
        attributes[.traits] = traits
        attributes[.family] = familyName
        //        print("fontWeight \(weight)")
        let descriptor = UIFontDescriptor(fontAttributes: attributes)
        
        return UIFont(descriptor: descriptor, size: pointSize)
        
    }
    
}
