//
//  ToastMessageModel.swift
//  Kamco
//
//  Created by systemira mobile on 29/05/2025.
//

import Foundation


public struct ToastMessage: Equatable {
    public let id = UUID()
    public let type: CustomToastType
    public let title: LocalizedStringKey
    public let message: LocalizedStringKey
    public let duration: Double
    
    public init(type: CustomToastType, title: LocalizedStringKey, message: LocalizedStringKey, duration: Double = 3.0) {
            self.type = type
            self.title = title
            self.message = message
            self.duration = duration
        }
}
