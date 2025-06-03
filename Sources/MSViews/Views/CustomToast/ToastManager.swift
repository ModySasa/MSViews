//
//  ToastManager.swift
//  Kamco
//
//  Created by systemira mobile on 29/05/2025.
//

import SwiftUI

public class ToastManager: ObservableObject {
    @Published var currentToast: ToastMessage?
    @Published var showToast: Bool = false
    
    public func show(type: CustomToastType, title: String , message: String , duration: Double = 3.0) {
        let toast = ToastMessage(
            type: type,
            title: title,
            message: message,
            duration: duration
        )
        
        withAnimation(.spring()){
            self.currentToast = toast
            self.showToast = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.hide()
        }
    }
    
    public func hide() {
        withAnimation(.easeOut(duration: 0.3)){
            self.showToast = false
        }
    }
}
