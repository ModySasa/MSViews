//
//  ToastConfiguration.swift
//  MSViews
//
//  Created by systemira mobile on 14/09/2025.
//

import SwiftUI
public struct ToastConfiguration {
    public let position: ToastPosition
    public let iconSize: CGFloat
    public let iconColor: Color
    public let titleFont: Font
    public let titleColor: Color
    public let messageFont: Font
    public let messageColor: Color
    public let backgroundColor: Color
    public let cornerRadius: CGFloat
    public let horizontalPadding: CGFloat
    public let verticalPadding: CGFloat
    public let spacing: CGFloat
    public let shadowColor: Color
    public let shadowRadius: CGFloat
    public let shadowOffset: CGSize
    public let closeButtonSize: CGFloat
    public let closeButtonColor: Color
    public let messageLineLimit: Int?
    public let height: CGFloat?
    public let showCloseButton: Bool
    
    public init(
        position: ToastPosition = .bottom,
        iconSize: CGFloat = 24,
        iconColor: Color = .white,
        titleFont: Font = .headline,
        titleColor: Color = .white,
        messageFont: Font = .subheadline,
        messageColor: Color = .white.opacity(0.8),
        backgroundColor: Color = .blue,
        cornerRadius: CGFloat = 12,
        horizontalPadding: CGFloat = 16,
        verticalPadding: CGFloat = 12,
        spacing: CGFloat = 12,
        shadowColor: Color = .black.opacity(0.15),
        shadowRadius: CGFloat = 8,
        shadowOffset: CGSize = CGSize(width: 0, height: 4),
        closeButtonSize: CGFloat = 16,
        closeButtonColor: Color = .white.opacity(0.8),
        messageLineLimit: Int? = 2,
        height: CGFloat? = nil,
        showCloseButton: Bool = true
    ) {
        self.position = position
        self.iconSize = iconSize
        self.iconColor = iconColor
        self.titleFont = titleFont
        self.titleColor = titleColor
        self.messageFont = messageFont
        self.messageColor = messageColor
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.horizontalPadding = horizontalPadding
        self.verticalPadding = verticalPadding
        self.spacing = spacing
        self.shadowColor = shadowColor
        self.shadowRadius = shadowRadius
        self.shadowOffset = shadowOffset
        self.closeButtonSize = closeButtonSize
        self.closeButtonColor = closeButtonColor
        self.messageLineLimit = messageLineLimit
        self.height = height
        self.showCloseButton = showCloseButton
    }
}

// MARK: - Default Configurations
public extension ToastConfiguration {
    static let `default` = ToastConfiguration()
    
    static let success = ToastConfiguration(
        iconColor: .white,
        backgroundColor: .green,
        shadowColor: .green.opacity(0.2)
    )
    
    static let error = ToastConfiguration(
        iconColor: .white,
        backgroundColor: .red,
        shadowColor: .red.opacity(0.2)
    )
    
    static let warning = ToastConfiguration(
        iconColor: .white,
        backgroundColor: .orange,
        shadowColor: .orange.opacity(0.2)
    )
    
    static let info = ToastConfiguration(
        iconColor: .white,
        backgroundColor: .blue,
        shadowColor: .blue.opacity(0.2)
    )
    
    static let compact = ToastConfiguration(
        iconSize: 20,
        titleFont: .caption,
        messageFont: .caption2,
        horizontalPadding: 12,
        verticalPadding: 8,
        spacing: 8,
        height: 60
    )
    
    static let large = ToastConfiguration(
        iconSize: 32,
        titleFont: .title2,
        messageFont: .body,
        horizontalPadding: 20,
        verticalPadding: 16,
        spacing: 16,
        messageLineLimit: nil,
        height: 120
    )
}
