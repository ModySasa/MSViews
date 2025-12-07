//
//  ToastManager.swift
//  Kamco
//
//  Created by systemira mobile on 29/05/2025.
//

import SwiftUI

public class ToastManager: ObservableObject {
    
    public static let shared = ToastManager()
    
    @Published var currentToast: ToastMessage?
    @Published var showToast: Bool = false
    
    private var appConfiguration: ToastConfiguration = ToastConfiguration()
    private var hideTask: DispatchWorkItem?
    
    public init() {
        
    }
    
    public func configureApp(with configuration: ToastConfiguration) {
            self.appConfiguration = configuration
    }
    
    public func show(type: CustomToastType, title: LocalizedStringKey , message: LocalizedStringKey , duration: Double = 3.0) {
        let toast = ToastMessage(
            type: type,
            title: title,
            message: message,
            duration: duration
        )
        hideTask?.cancel()
        
        currentToast = ToastMessage(type: type, title: title, message: message, duration: duration)
        
        withAnimation(.spring()) {
            showToast = true
        }
        
        
        
        let task = DispatchWorkItem {
            self.hide()
        }
        hideTask = task
        DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: task)
    }
    
    public func showWithCustomConfig(
            type: CustomToastType,
            title: String,
            message: String,
            duration: Double = 3.0,
            configuration: ToastConfiguration
        ) {
            // This is for rare cases where you want to override the app config
            hideTask?.cancel()
            
            // Temporarily store the custom config
            let originalConfig = appConfiguration
            appConfiguration = configuration
            
            currentToast = ToastMessage(type: type, title: title, message: message, duration: duration)
            
            withAnimation(.spring()) {
                showToast = true
            }
            
            let task = DispatchWorkItem {
                self.hide()
                // Restore original config after hiding
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.appConfiguration = originalConfig
                }
            }
            hideTask = task
            DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: task)
        }
    
    public func hide() {
           hideTask?.cancel()
           
           withAnimation(.spring()) {
               showToast = false
           }
           
           DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
               self.currentToast = nil
           }
       }
       
       // Internal getter for the current configuration
       internal var currentConfiguration: ToastConfiguration {
           return appConfiguration
       }
}
