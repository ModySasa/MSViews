//
//  NotificationsHelper.swift
//  
//
//  Created by Mohamed safwat on 26/11/2023.
//

import Foundation
import UIKit

public func setBadgeNum(_ count : Int = -100){
    var notificationsCount = msViews.sharedPrefHelper.getSharedPref(key: .notificationsBadge) as? Int ?? 0
    if (count == -100){
        notificationsCount += 1
    } else {
        notificationsCount = count
    }
    msViews.sharedPrefHelper.setSharedPref(key: .notificationsBadge, value: notificationsCount as AnyObject)
    updateBadgeNum(notificationsCount)
}

public func updateBadgeNum(_ count : Int) {
    UIApplication.shared.applicationIconBadgeNumber = count
}

public func setNotLangDefault(_ bundleName:String , lang : LangEnum){
    if let defaults = UserDefaults(suiteName: "\(bundleName).notbundles"){
        defaults.set( lang.rawValue , forKey: "notLang")
    }
}
