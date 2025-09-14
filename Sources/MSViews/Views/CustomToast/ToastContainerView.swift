//
//  ToastContainerView.swift
//  MSViews
//
//  Created by systemira mobile on 14/09/2025.
//


public struct ToastContainerView<Content: View>: View {
    let content: Content
    @StateObject private var toastManager = ToastManager.shared
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        ZStack(alignment: toastManager.currentConfiguration.position.alignment) {
            content
            
            if toastManager.showToast, let toast = toastManager.currentToast {
                Group {
                    switch toastManager.currentConfiguration.position {
                    case .top:
                        VStack {
                            toastView(toast: toast)
                            Spacer()
                        }
                    case .middle:
                        toastView(toast: toast)
                    case .bottom:
                        VStack {
                            Spacer()
                            toastView(toast: toast)
                        }
                    }
                }
                .transition(toastManager.currentConfiguration.position.transition)
                .animation(.spring(), value: toastManager.showToast)
                .zIndex(999)
            }
        }
    }
    
    private func toastView(toast: ToastMessage) -> some View {
        CustomToastView(
            toast: toast,
            configuration: toastManager.currentConfiguration,
            onDismiss: {
                toastManager.hide()
            }
        )
        .gesture(
            DragGesture()
                .onEnded { value in
                    let dragThreshold: CGFloat = 50
                    switch toastManager.currentConfiguration.position {
                    case .top:
                        if value.translation.y < -dragThreshold {
                            toastManager.hide()
                        }
                    case .bottom:
                        if value.translation.y > dragThreshold {
                            toastManager.hide()
                        }
                    case .middle:
                        if abs(value.translation.x) > dragThreshold || abs(value.translation.y) > dragThreshold {
                            toastManager.hide()
                        }
                    }
                }
        )
        .onTapGesture {
            toastManager.hide()
        }
        .padding(toastManager.currentConfiguration.position == .top ? .top : .bottom, 
                toastManager.currentConfiguration.position == .middle ? 0 : 50)
    }
}

// MARK: - App Setup Helper
extension View {
    /// Setup toast container with app-level configuration (use only at app root)
    public func setupToast(configuration: ToastConfiguration) -> some View {
        ToastManager.shared.configureApp(with: configuration)
        return ToastContainerView {
            self
        }
    }
}

// MARK: - Global Toast Functions (Uses App Configuration)
public struct Toast {
    /// Show success toast using app configuration
    public static func success(_ title: String, message: String = "", duration: Double = 3.0) {
        ToastManager.shared.show(type: .success, title: title, message: message, duration: duration)
    }
    
    /// Show error toast using app configuration
    public static func error(_ title: String, message: String = "", duration: Double = 4.0) {
        ToastManager.shared.show(type: .error, title: title, message: message, duration: duration)
    }
    
    /// Show warning toast using app configuration
    public static func warning(_ title: String, message: String = "", duration: Double = 3.5) {
        ToastManager.shared.show(type: .warning, title: title, message: message, duration: duration)
    }
    
    /// Show info toast using app configuration
    public static func info(_ title: String, message: String = "", duration: Double = 3.0) {
        ToastManager.shared.show(type: .info, title: title, message: message, duration: duration)
    }
    
    /// Show custom toast with app configuration
    public static func show(type: CustomToastType, title: String, message: String = "", duration: Double = 3.0) {
        ToastManager.shared.show(type: type, title: title, message: message, duration: duration)
    }
    
    /// Show toast with custom configuration (rare use case - overrides app config)
    public static func showCustom(
        type: CustomToastType,
        title: String,
        message: String = "",
        duration: Double = 3.0,
        configuration: ToastConfiguration
    ) {
        ToastManager.shared.showWithCustomConfig(
            type: type,
            title: title,
            message: message,
            duration: duration,
            configuration: configuration
        )
    }
    
    /// Hide current toast
    public static func hide() {
        ToastManager.shared.hide()
    }
}