//
//  ToastMessageModel.swift
//  Kamco
//
//  Created by systemira mobile on 29/05/2025.
//

import Foundation


struct ToastMessage: Equatable {
    let id = UUID()
    let type: CustomToastType
    let title: String
    let message: String
    let duration: Double
}
