//
//  File.swift
//  
//
//  Created by Corptia 02 on 15/08/2023.
//

import Foundation
import SwiftUI

public struct PickerItem : Identifiable , Hashable {
    public var id : Int
    public var title : String
    public var Image : String?
    public var object : AnyHashable
    
    public var localizedTitle: LocalizedStringKey {
            LocalizedStringKey(title)
        }
    
    public init(id: Int, title: String, Image: String? = nil, object: AnyHashable) {
        self.id = id
        self.title = title
        self.Image = Image
        self.object = object
    }
}
