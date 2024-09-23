//
//  Array.swift
//  MSViews
//
//  Created by Moha on 9/23/24.
//

import Foundation

extension Array where Element: Equatable {
    mutating func clear() {
        self.removeAll()
    }
    
    var isNotEmpty: Bool {
        !self.isEmpty
    }
}
