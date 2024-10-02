//
//  SwiftUIView.swift
//  
//
//  Created by Moha on 10/2/24.
//

import SwiftUI
import Combine

final class KeyboardResponder: ObservableObject {
    @Published var currentHeight: CGFloat = 0
    private var cancellable: AnyCancellable?

    init() {
        self.cancellable = Publishers.Merge(
            NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
                .map { $0.keyboardHeight },
            NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
                .map { _ in CGFloat(0) }
        )
        .assign(to: \.currentHeight, on: self)
    }
}

extension Notification {
    var keyboardHeight: CGFloat {
        (self.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
    }
}

struct PushViewsWithKeyboardMod : ViewModifier {
    @ObservedObject private var keyboardResponder = KeyboardResponder()
    
    func body(content: Content) -> some View {
        content
            .padding(.bottom, keyboardResponder.currentHeight) // Adjust view based on keyboard height
            .animation(.easeOut(duration: 0.05)) // Smooth transition
    }
}

public extension View {
    @ViewBuilder
    func pushViews() -> some View {
        modifier(PushViewsWithKeyboardMod())
    }
}
