//
//  File.swift
//  
//
//  Created by Corptia 02 on 16/08/2022.
//

import Foundation

//// custom printing methods
public class Printing {
    public static let shared = Printing.init()
    
    public func isTesting()->Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
    
    public func tagPrint(_ data:String ,_ isData:Bool = false , isUrl:Bool = false){
        if(isTesting()){
            if(isData) {
                print("dataPrint: \(data)")
            } else {
                if(isUrl){
                    print("urlPrint: \(data)")
                } else {
                    print("tagPrint: \(data)")
                }
            }
        }
    }

    public func printData(data:Data){
        if(isTesting()) {
            if(String(data: data, encoding: .utf8) != nil){
                //        tagPrint("time elapsed = \(sendingDate.timeIntervalSinceNow * -1) milliseconds" , true)
                tagPrint("Server response is :\n\(String(data: data, encoding: .utf8)!)" , true)
            }
        }
    }
    
    public func printUrl(url:String){
        if(isTesting()){
            tagPrint(url , isUrl:true)
        }
    }
    
}
