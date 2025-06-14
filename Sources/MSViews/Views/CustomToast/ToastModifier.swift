//
//  ToastModifier.swift
//  Kamco
//
//  Created by systemira mobile on 29/05/2025.
//

import SwiftUI


public struct ToastModifier: ViewModifier {
    @ObservedObject var toastManager: ToastManager
    
    public func body(content: Content) -> some View {
        ZStack{
            content
            
            if toastManager.showToast , let toast = toastManager.currentToast{
                VStack{
                    Spacer()
                    
                    CustomToastView(toast: toast)
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
                .padding(.bottom , 16)
                .animation(.spring(), value: toastManager.showToast)
                .zIndex(100)
            }
        }
    }
}

extension View {
    
    public func toast(manager: ToastManager) -> some View {
        self.modifier(ToastModifier(toastManager: manager))
    }
}
