//
//  TopLevelConstants.swift
//  Sonqr
//
//  Created by Mohamed Safwat on 23/12/2020.
//

import Foundation

public var fireBaseToken = "noToken"

public extension Notification.Name {
    static let NotCount = Notification.Name(rawValue: "notCount")
}

public var notCount: Int = -1 {
    didSet {
        NotificationCenter.default.post(name: .NotCount, object: nil)
    }
}

public let msViews = MSViews.init()
