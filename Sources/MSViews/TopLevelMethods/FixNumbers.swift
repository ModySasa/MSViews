//
//  File.swift
//  
//
//  Created by Corptia 02 on 16/08/2022.
//

import Foundation

//// fixing double numbers
public class FixNumbers{
    public static let shared = FixNumbers.init()
    
    public func fixDouble(number:Double ,_ count:Int = 2) -> String {
        if(count == 3) {
            return String(format: "%.03f", number)
        } else if (count == 1) {
            return String(format: "%.01f", number)
        } else {
            return String(format: "%.02f", number)
        }
    }
    
    public func fixNumber(number:NSNumber , _ count:Int = 2) -> String {
        if number as AnyObject is Int {
            if count == 3 {
                return "\(number).000"
            } else if (count == 1) {
                return "\(number).0"
            } else {
                return "\(number).00"
            }
        } else {
            let dbl :Double = number as! Double
            return fixDouble(number: dbl , count)
        }
    }
    
}
