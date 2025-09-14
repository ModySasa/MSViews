//
//  ToastPosition.swift
//  MSViews
//
//  Created by systemira mobile on 14/09/2025.
//


import SwiftUI

// MARK: - Toast Position
public enum ToastPosition {
    case top
    case middle
    case bottom
    
    public var alignment: Alignment {
        switch self {
        case .top:
            return .top
        case .middle:
            return .center
        case .bottom:
            return .bottom
        }
    }
    
    public var transition: AnyTransition {
        switch self {
        case .top:
            return .move(edge: .top).combined(with: .opacity)
        case .middle:
            return .scale.combined(with: .opacity)
        case .bottom:
            return .move(edge: .bottom).combined(with: .opacity)
        }
    }
}
