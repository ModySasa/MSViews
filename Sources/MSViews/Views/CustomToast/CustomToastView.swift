//
//  ToastView.swift
//  Kamco
//
//  Created by systemira mobile on 29/05/2025.
//

import SwiftUI

public struct CustomToastView: View {
    let toast: ToastMessage
    public var body: some View {
        HStack(alignment: .center , spacing: 12) {
            Image(systemName: toast.type.icon)
                .font(.system(size: 24))
                .foregroundStyle(.white)
                .frame(width: 30, height: 30)
            
            VStack(alignment: .leading , spacing: 4) {
                Text(toast.title)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text(toast.message)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
                    .lineLimit(2)
            }
            
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 16 , weight: .bold))
                    .foregroundStyle(.white.opacity(0.8))
            }

        }
        .padding(.horizontal , 16)
        .padding(.vertical , 12)
        .background(RoundedRectangle(cornerRadius: 12)
            .fill(toast.type.themeColor)
            .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 4)
        )
        .padding(.horizontal , 16)
    }
}

#Preview {
    CustomToastView(toast: .init(type: .error, title: "title", message: "message", duration: 3.0))
}
