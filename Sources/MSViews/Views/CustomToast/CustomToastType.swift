//
//  ToastType.swift
//  Kamco
//
//  Created by systemira mobile on 29/05/2025.
//

import SwiftUI

public enum CustomToastType {
    case success
    case error
    case warning
    case info
    
    
    var themeColor: Color {
        switch self {
        case .success:
            return Color.green
        case .error:
            return Color.red
        case .warning:
            return Color.orange
        case .info:
            return Color.blue
        }
    }
    
    var icon: String {
        switch self {
        case .success:
            return "checkmark.circle.fill"
        case .error:
            return "exclamationmark.triangle.fill"
        case .warning:
            return "exclamationmark.circle.fill"
        case .info:
            return "info.circle.fill"
        }
    }
}
