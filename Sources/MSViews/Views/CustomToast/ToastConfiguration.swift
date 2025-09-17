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
    public let titleSize : CGFloat
    public let titleWeight : Font.Weight
    public let titleColor: Color
    public let messageSize : CGFloat
    public let messageWeight : Font.Weight
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
    
    // Custom colors and icons for each toast type
    public let successColor: Color
    public let successIcon: String
    public let errorColor: Color
    public let errorIcon: String
    public let warningColor: Color
    public let warningIcon: String
    public let infoColor: Color
    public let infoIcon: String
    public let closeButtonIcon: String
    
    public init(
        position: ToastPosition = .bottom,
        iconSize: CGFloat = 24,
        iconColor: Color = .white,
        titleSize: CGFloat = 16,
        titleWeight: Font.Weight = .regular,
        titleColor: Color = .white,
        messageSize: CGFloat = 14,
        messageWeight: Font.Weight = .regular,
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
        showCloseButton: Bool = true,
        // Custom theme properties
        successColor: Color = .green,
        successIcon: String = "checkmark.circle.fill",
        errorColor: Color = .red,
        errorIcon: String = "exclamationmark.triangle.fill",
        warningColor: Color = .orange,
        warningIcon: String = "exclamationmark.circle.fill",
        infoColor: Color = .blue,
        infoIcon: String = "info.circle.fill",
        closeButtonIcon: String = "xmark"
    ) {
        self.position = position
        self.iconSize = iconSize
        self.iconColor = iconColor
        self.titleSize = titleSize
        self.titleWeight = titleWeight
        self.titleColor = titleColor
        self.messageSize = messageSize
        self.messageWeight = messageWeight
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
        self.successColor = successColor
        self.successIcon = successIcon
        self.errorColor = errorColor
        self.errorIcon = errorIcon
        self.warningColor = warningColor
        self.warningIcon = warningIcon
        self.infoColor = infoColor
        self.infoIcon = infoIcon
        self.closeButtonIcon = closeButtonIcon
    }
    
    public func color(for type: CustomToastType) -> Color {
        switch type {
        case .success: return successColor
        case .error: return errorColor
        case .warning: return warningColor
        case .info: return infoColor
        }
    }
    
    public func icon(for type: CustomToastType) -> String {
        switch type {
        case .success: return successIcon
        case .error: return errorIcon
        case .warning: return warningIcon
        case .info: return infoIcon
        }
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
        titleSize: 16,
        messageSize: 14,
        horizontalPadding: 12,
        verticalPadding: 8,
        spacing: 8,
        height: 60
    )
    
    static let large = ToastConfiguration(
        iconSize: 32,
        titleSize: 18,
        messageSize: 16,
        horizontalPadding: 20,
        verticalPadding: 16,
        spacing: 16,
        messageLineLimit: nil,
        height: 120
    )
}
