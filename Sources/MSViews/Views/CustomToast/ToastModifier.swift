//
//  ToastModifier.swift
//  Kamco
//
//  Created by systemira mobile on 29/05/2025.
//

import SwiftUI


public struct ToastModifier: ViewModifier {
    @ObservedObject var toastManager: ToastManager
    let configuration: ToastConfiguration
        
        public init(toastManager: ToastManager, configuration: ToastConfiguration = .default) {
            self.toastManager = toastManager
            self.configuration = configuration
        }
        
        public func body(content: Content) -> some View {
            ZStack {
                content
                
                if toastManager.showToast, let toast = toastManager.currentToast {
                    VStack {
                        Spacer()
                        
                        CustomToastView(
                            toast: toast,
                            configuration: resolveConfiguration(for: toast.type),
                            onDismiss: {
                                toastManager.hide()
                            }
                        )
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                        .gesture(
                            DragGesture()
                                .onEnded { value in
                                    if value.translation.height < -20 {
                                        toastManager.hide()
                                    }
                                }
                        )
                        .onTapGesture {
                            toastManager.hide()
                        }
                    }
                    .padding(.bottom, 16)
                    .animation(.spring(), value: toastManager.showToast)
                    .zIndex(100)
                }
            }
        }
        
        private func resolveConfiguration(for type: ToastType) -> ToastConfiguration {
            // If a custom configuration is provided, use it with the appropriate background color
            var config = configuration
            
            // Override background color based on toast type if using default configuration
            if configuration.backgroundColor == ToastConfiguration.default.backgroundColor {
                switch type {
                case .success:
                    config = ToastConfiguration.success
                case .error:
                    config = ToastConfiguration.error
                case .warning:
                    config = ToastConfiguration.warning
                case .info:
                    config = ToastConfiguration.info
                }
            }
            
            return config
        }
    }

    // MARK: - View Extension
    extension View {
        public func toast(
            manager: ToastManager,
            configuration: ToastConfiguration = .default
        ) -> some View {
            self.modifier(ToastModifier(toastManager: manager, configuration: configuration))
        }
    }
