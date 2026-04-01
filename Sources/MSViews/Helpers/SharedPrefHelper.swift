//
//  SharedPrefHelper.swift
//  Sonqr
//
//  Created by Corptia 02 on 25/12/2021.
//

import Foundation

public class SharedPrefHelper{
    public static let shared = SharedPrefHelper.init()
    
    public func setSharedPref(key:defaultsKeys , value:AnyObject){
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key.rawValue)
    }
    
    public func getSharedPref(key:defaultsKeys) -> AnyObject{
        let defaults = UserDefaults.standard
        if(key == .notFirstTime || key == .hideNot){
            return defaults.bool(forKey: key.rawValue) as AnyObject
        } else if(key == .rememberMe || key == .startWorking){
            return defaults.bool(forKey: key.rawValue) as AnyObject
        } else if(key == .projectId || key == .countryId || key == .unitId || key == .notificationsBadge){
            return defaults.integer(forKey: key.rawValue) as AnyObject
        } else {
            if let stringOne = defaults.string(forKey: key.rawValue) {
                return stringOne as AnyObject
            } else{
                return "NIL" as AnyObject
            }
        }
    }
    
    
    public func setSharedPref<T>(key: String, value: T) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
    }
    
    public func getSharedPref<T>(key: String) -> T? {
        let defaults = UserDefaults.standard
        
        if T.self == Bool.self {
            return defaults.bool(forKey: key) as? T
        } else if T.self == Int.self {
            return defaults.integer(forKey: key) as? T
        } else if T.self == String.self {
            return defaults.string(forKey: key) as? T
        } else if T.self == Double.self {
            return defaults.double(forKey: key) as? T
        } else if T.self == Float.self {
            return defaults.float(forKey: key) as? T
        } else if T.self == Data.self {
            return defaults.data(forKey: key) as? T
        } else {
            return defaults.object(forKey: key) as? T
        }
    }
    
    public func removeAllSharedKeys(){
        let defaults = UserDefaults.standard
        for key in appKeys {
            defaults.removeObject(forKey: key)
        }
    }
    
    public var appKeys = [String].init(arrayLiteral:
                                        defaultsKeys.userName.rawValue ,
                                       defaultsKeys.userPass.rawValue ,
                                       defaultsKeys.rememberMe.rawValue ,
                                       defaultsKeys.startWorking.rawValue,
                                       defaultsKeys.token.rawValue ,
                                       defaultsKeys.projectId.rawValue ,
                                       defaultsKeys.lang.rawValue,
                                       defaultsKeys.userImage.rawValue,
                                       defaultsKeys.phone.rawValue,
                                       defaultsKeys.countryId.rawValue,
                                       defaultsKeys.mainUrl.rawValue,
                                       defaultsKeys.testUrl.rawValue,
                                       defaultsKeys.hideNot.rawValue,
                                       defaultsKeys.countryCodeTest.rawValue
    )
    
}

public enum defaultsKeys:String {
    case userName = "UserName"
    case userPass = "Password"
    case notFirstTime = "Renewing"
    case rememberMe = "RememberMe"
    case token = "token"
    case lang = "Lang"
    case userImage = "userImage"
    case phone = "userPhone"
    case countryId = "countryId"
    case mainUrl = "mainUrl"
    case testUrl = "testUrl"
    case hideNot = "hideNot"
    case countryCodeTest = "countryCodeTest"
    case userlatitude = "userlatitude"
    case notificationsBadge = "notificationsBadge"
    case userlongitude = "userlongitude"
    
    case startWorking = "startWorking"
    
    case projectId = "ProjectID"
    case unitId = "unitId"
}
