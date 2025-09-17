//
//  ToastView.swift
//  Kamco
//
//  Created by systemira mobile on 29/05/2025.
//

import SwiftUI

public struct CustomToastView: View {
    let toast: ToastMessage
    let configuration: ToastConfiguration
    let onDismiss: () -> Void
    
    public init(
        toast: ToastMessage,
        configuration: ToastConfiguration = .default,
        onDismiss: @escaping () -> Void = {}
    ) {
        self.toast = toast
        self.configuration = configuration
        self.onDismiss = onDismiss
    }
    
    public var body: some View {
            HStack(alignment: .center, spacing: configuration.spacing) {
                Image(configuration.icon(for: toast.type))
                    .font(.system(size: configuration.iconSize))
                    .foregroundStyle(configuration.iconColor)
                    .frame(width: configuration.iconSize + 6, height: configuration.iconSize + 6)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(toast.title)
                        .font(configuration.titleFont)
                        .foregroundColor(configuration.titleColor)
                    
                    Text(toast.message)
                        .font(configuration.messageFont)
                        .foregroundColor(configuration.messageColor)
                        .lineLimit(configuration.messageLineLimit)
                }
                
                Spacer()
                
                if configuration.showCloseButton {
                    Button {
                        onDismiss()
                    } label: {
                        Image(configuration.closeButtonIcon)
                            .font(.system(size: configuration.closeButtonSize, weight: .bold))
                            .foregroundStyle(configuration.closeButtonColor)
                    }
                }
            }
            .padding(.horizontal, configuration.horizontalPadding)
            .padding(.vertical, configuration.verticalPadding)
            .frame(height: configuration.height)
            .background(
                RoundedRectangle(cornerRadius: configuration.cornerRadius)
                    .fill(configuration.color(for: toast.type))
                    .shadow(
                        color: configuration.color(for: toast.type).opacity(0.4),
                        radius: configuration.shadowRadius,
                        x: configuration.shadowOffset.width,
                        y: configuration.shadowOffset.height
                    )
            )
            .padding(.horizontal, 16)
        }
    
    private func resolveBackgroundColor() -> Color {
            // Always use the toast type's theme color for consistency
            return toast.type.themeColor
        }
    }

#Preview {
    CustomToastView(toast: .init(type: .error, title: "title", message: "message", duration: 3.0))
}
