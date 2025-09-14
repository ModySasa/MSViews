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
    public let title: String
    public let message: String
    public let duration: Double
}
