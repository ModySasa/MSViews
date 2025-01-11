//
//  Array.swift
//  MSViews
//
//  Created by Moha on 9/23/24.
//

import Foundation
import SwiftUI

public extension Array where Element: Equatable {
    mutating func clear() {
        self.removeAll()
    }
    
    var isNotEmpty: Bool {
        !self.isEmpty
    }
}

public extension Array where Element: Identifiable {
    func forEachView<V: View>(@ViewBuilder content: @escaping (Element) -> V) -> some View {
        ForEach(self, id: \.id) { item in
            content(item)
        }
    }
}
