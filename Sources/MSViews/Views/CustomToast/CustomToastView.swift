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
                    if !toast.title.isEmpty{
                        Text(toast.title)
                            .font(.custom(getAppFont(configuration.titleWeight), size: configuration.titleSize).weight(configuration.titleWeight))
                            .foregroundColor(configuration.titleColor(for: toast.type))
                    }
                    Text(toast.message)
                        .font(.custom(getAppFont(configuration.messageWeight), size: configuration.messageSize).weight(configuration.messageWeight))
                        .foregroundColor(configuration.messageColor(for: toast.type))
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
    
    }

#Preview {
    CustomToastView(toast: .init(type: .error, title: "title", message: "message", duration: 3.0))
}
