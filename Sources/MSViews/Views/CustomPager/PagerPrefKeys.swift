//
//  File.swift
//
//
//  Created by Corptia 02 on 13/05/2023.
//

import Foundation
import SwiftUI

public struct PagerItemsPreferenceKey : PreferenceKey {
    public static var defaultValue: [PagerItem] = .init()
    
    public static func reduce(value: inout [PagerItem], nextValue: () -> [PagerItem]) {
        value += nextValue()
    }
    
}

public struct HasPagerIndicatorPreferenceKey : PreferenceKey {
    public static var defaultValue: Bool = true
    
    public static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
}

public struct SetPagerIndicatorSelectedColorPreferenceKey : PreferenceKey {
    public static var defaultValue: Color = .yellow
    
    public static func reduce(value: inout Color, nextValue: () -> Color) {
        value = nextValue()
    }
}

public struct SetPagerIndicatorUnSelectedColorPreferenceKey : PreferenceKey {
    public static var defaultValue: Color = .red
    
    public static func reduce(value: inout Color, nextValue: () -> Color) {
        value = nextValue()
    }
}

public struct SetPagerIndicatorSelectedWidthPreferenceKey : PreferenceKey {
    public static var defaultValue: CGFloat = 10
    
    public static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

public struct SetPagerIndicatorUnSelectedWidthPreferenceKey : PreferenceKey {
    public static var defaultValue: CGFloat = 10
    
    public static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

public struct SetPagerIndicatorHeightPreferenceKey : PreferenceKey {
    public static var defaultValue: CGFloat = 10
    
    public static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

public struct PagerItemViewModeifier : ViewModifier {
    let tab:PagerItem
    @Binding var selection: Int
    
    public func body(content: Content) -> some View {
        let isSelected = tab.index == selection
        content
            .opacity(isSelected ? 1 : 0)
            .preference(key: PagerItemsPreferenceKey.self, value: [tab])
    }
}

public extension View {
    
    func pagerItem(
        _ tab:PagerItem ,
        selection:Binding<Int>
    ) ->some View {
        modifier(
            PagerItemViewModeifier(
                tab: tab ,
                selection:selection
            ))
    }
    
    func hasPagerIndicatorView(_ hasBar : Bool = true) -> some View {
        preference(key: HasPagerIndicatorPreferenceKey.self, value: hasBar)
    }
}
