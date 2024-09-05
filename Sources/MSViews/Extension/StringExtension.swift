//
//  StringExtension.swift
//
//
//  Created by Corptia 02 on 16/08/2022.
//

import Foundation
import UIKit

public extension String {
    func hashMiddle(_ startCount : Int = 3,_ endCount : Int = 3) -> String{
        var string_to_return = ""
        var start_string = ""
        var end_string = ""
        var mid_string = ""
        var myString = self
        
        if(self.count > (startCount + endCount)) {
            for _ in 1...startCount {
                start_string = "\(start_string)\(myString.first!)"
                myString.removeFirst()
            }
            for _ in 1...endCount {
                end_string = "\(myString.last!)\(end_string)"
                myString.removeLast()
            }
            for _ in 1...myString.count {
                mid_string = "\(mid_string)*"
            }
            string_to_return = "\(start_string)\(mid_string)\(end_string)"
            return string_to_return
        } else {
            return self
        }
    }
    
    var underLined: NSAttributedString {
        NSMutableAttributedString(string: self, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
    }
    
    func size(with font: UIFont) -> CGSize {
        let fontAttribute = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttribute)
        return size
    }
}


//
//public extension String {
//    
//    func strikeThrough() -> NSAttributedString {
//        let attributeString =  NSMutableAttributedString(string: self)
//        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0,attributeString.length))
//        return attributeString
//    }
//    
//    var htmlToAttributedString: NSAttributedString? {
//        guard let data = data(using: .utf8) else { return NSAttributedString() }
//        do {
//            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
//        } catch {
//            return NSAttributedString()
//        }
//    }
//    
//    var htmlToString: String {
//        return htmlToAttributedString?.string ?? ""
//    }
//    
//    func urlWithChrs() -> String {
//        let urlWithArabicChars = addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
//        if let urlWithArabicChrs = urlWithArabicChars {
//            return urlWithArabicChrs
//        }
//        return self
//    }
//    
//    // regex validatin
//    enum ValidationType: String {
//        case alphabet = "[A-Za-z]+"
//        case alphabetWithSpace = "[A-Za-z ]*"
//        case alphabetNum = "[A-Za-z-0-9]*"
//        //            case alphabetNumWithDash = "[A-Za-z-0-9\-]*"
//        case cardIdValidation = "(2|3)[0-9]{2}[0-1][0-9][0-3][0-9](01|02|03|04|11|12|13|14|15|16|17|18|19|21|22|23|24|25|26|27|28|29|31|32|33|34|35|88)[0-9]{5}"
//    }
//    
//    func isValid(_ type: ValidationType) -> Bool {
//        guard !isEmpty else { return false }
//        let regTest = NSPredicate(format: "SELF MATCHES %@", type.rawValue)
//        return regTest.evaluate(with: self)
//    }
//    
//    mutating func setMaxChrs(_ chrs:Int) {
//        if(count > chrs) {
//            let chrs = self.prefix(chrs).map{String($0)}
//            self = chrs[0]
//            for chr in chrs {
//                self += chr
//            }
//            self += "..."
//        }
//    }
//    
//    var underLined: NSAttributedString {
//        NSMutableAttributedString(string: self, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
//    }
//    
//}
