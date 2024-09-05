//
//  SwiftUIView.swift
//  
//
//  Created by Corptia 02 on 19/04/2023.
//

import SwiftUI

public struct ToastView: View {
    @Binding var toast:Toast
    @State var opacity : Double = 1.0
    
    let timer = Timer.publish(every: 0.08, on: .main, in: .common).autoconnect()
    
    public init(toast: Binding<Toast>) {
        self._toast = toast
    }
    
    public var body: some View {
        checkToastMessage()
    }
    
    @ViewBuilder func checkToastMessage() -> some View{
        VStack{
            Spacer()
            Spacer()
            Spacer()
            showToast()
            Spacer()
        }
    }
    
    @ViewBuilder func showToast() -> some View{
        Text(toast.message)
            .textStyle(.main)
            .foregroundColor(.white)
            .padding()
            .onReceive(timer, perform: { _ in
                handleOpacity()
            })
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(getColor())
                    .opacity(opacity)
            )
    }
    
    func handleOpacity(){
        if(opacity > 0.7) {
            opacity -= 0.015
        } else if(opacity > 0.5) {
            opacity -= 0.03
        } else if(opacity > 0) {
            opacity -= 0.1
        } else {
            opacity = 0
            toast = .init()
        }
    }
    
    func getColor() -> Color {
        switch toast.type {
        case .error:
            return .red
        case .warning:
            return .yellow
        case .info:
            return .blue
        default:
            return .green
        }
    }
    
}

struct ToastViewPreviewhelper : View {
    @State var toast: Toast = .init(message: "Test toast", type: .error)
    var body: some View {
        ToastView(toast: $toast)
    }
}

struct ToastView_Previews: PreviewProvider {
    static var previews: some View {
        ToastViewPreviewhelper()
    }
}
