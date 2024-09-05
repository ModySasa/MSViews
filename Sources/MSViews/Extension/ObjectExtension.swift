//
//  File.swift
//  
//
//  Created by Corptia 02 on 16/08/2022.
//

import Foundation

public extension NSObject {
    var theClassName: String {
        return NSStringFromClass(type(of: self))
    }
}

public class Utility{
    public class func classNameAsString(_ obj: Any) -> String {
        //prints more readable results for dictionaries, arrays, Int, etc
        return String(describing: type(of: obj))
    }
}
