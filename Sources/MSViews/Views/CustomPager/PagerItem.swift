//
//  PagerItem.swift
//  
//
//  Created by Corptia 02 on 21/05/2023.
//

import Foundation
import SwiftUI

public struct PagerItem : Hashable , Identifiable {
    public static func == (lhs: PagerItem, rhs: PagerItem) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public var id: Int {
        get {
            return self.index
        }
    }
    
    public let iconName: String
    public let title: String
    public let index: Int
    public let description: String
    public let object : AnyObject?
    
    public init(_ index:Int){
        self.iconName = ""
        self.title = ""
        self.description = ""
        self.index = index
        self.object = nil
    }
    
    public init(
        iconName: String,
        title: String,
        index: Int,
        description:String,
        object:AnyObject
    ) {
        self.iconName = iconName
        self.title = title
        self.index = index
        self.description = description
        self.object = object
    }
    
}

