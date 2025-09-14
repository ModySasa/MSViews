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
    
//    public init(
//        toast: ToastMessage,
//        configuration: ToastConfiguration = .default,
//        onDismiss: @escaping () -> Void = {}
//    ) {
//        self.toast = toast
//        self.configuration = configuration
//        self.onDismiss = onDismiss
//    }
    
    public var body: some View {
            HStack(alignment: .center, spacing: configuration.spacing) {
                Image(systemName: toast.type.icon)
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
                
                Button {
                    onDismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: configuration.closeButtonSize, weight: .bold))
                        .foregroundStyle(configuration.closeButtonColor)
                }
            }
            .padding(.horizontal, configuration.horizontalPadding)
            .padding(.vertical, configuration.verticalPadding)
            .frame(height: configuration.height)
            .background(
                RoundedRectangle(cornerRadius: configuration.cornerRadius)
                    .fill(configuration.backgroundColor)
                    .shadow(
                        color: configuration.shadowColor,
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
