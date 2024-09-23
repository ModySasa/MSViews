//
//  MainTextField.swift
//  Learn no core
//
//  Created by Corptia 02 on 28/03/2023.
//

import SwiftUI

public struct OneLineField: View {
    @Binding var txt : String
//    @Binding var isSecured : Bool
    @State var isSecured : Bool = true
    @Binding var errorText : String
    var shouldHasBorder : Bool
    var borderColor : Color = msViews.viewsHelper.borderColor
    var hasError : Bool = false
    var placeHolder : String = "PlaceHolder"
    var placeHolderColor : Color = .gray.opacity(0.7)
    var isPassword : Bool = false
    var checkStrength : Bool = false
    var disabled : Bool = false
    var type : UIKeyboardType = .default
    var submitLabel : SubmitLabel = .return
    var padding : CGFloat = 14
    var passIconPadding : CGFloat = 14
    var radius : CGFloat = 11.5
    var textSize : CGFloat = 14
    var textWeight : Font.Weight = .regular
    var textColor : Color = .black
    var fieldBackgroundColor : Color = .white
    var height: CGFloat = msViews.margins.mainButtonHeight
    var onSubmit : ((String)->Void)! = nil
    var onTextChange: ((String)->Void)! = nil
    
    public init(
        txt:Binding<String>,
        errorText:Binding<String>,
        placeHolder:String = "" ,
        placeHolderColor: Color = .gray.opacity(0.7),
        isPassword:Bool = false,
//        isSecured:Binding<Bool> = .constant(false),
        checkStrength:Bool = false,
        disabled:Bool = false,
        shouldHasBorder : Bool = true ,
        borderColor:Color = msViews.viewsHelper.borderColor,
        hasError : Bool = false,
        type:UIKeyboardType = .default,
        submitLabel:SubmitLabel = .return,
        padding:CGFloat = 14,
        passIconPadding:CGFloat = 14,
        radius:CGFloat = 11.5,
        textSize:CGFloat = 14,
        textWeight:Font.Weight = .regular ,
        textColor: Color = .black,
        fieldBackgroundColor : Color = .white,
        height: CGFloat = msViews.margins.mainButtonHeight,
        onSubmit:@escaping (String)->Void,
        onTextChange:@escaping (String)->Void
    ) {
        self._txt = txt
        self._errorText = errorText
        self.placeHolder = placeHolder
        self.placeHolderColor = placeHolderColor
        self.isPassword = isPassword
//        self._isSecured = isSecured
        self.checkStrength = checkStrength
        self.disabled = disabled
        self.type = type
        self.submitLabel = submitLabel
        self.padding = padding
        self.passIconPadding = passIconPadding
        self.radius = radius
        self.textSize = textSize
        self.textWeight = textWeight
        self.textColor = textColor
        self.height = height
        self.onSubmit = onSubmit
        self.onTextChange = onTextChange
        self.fieldBackgroundColor = fieldBackgroundColor
        self.shouldHasBorder = shouldHasBorder
        self.borderColor = borderColor
        self.hasError = hasError
    }
    
    public var body: some View {
        VStack(alignment: .leading , spacing: 8) {
            oneLineField
            if(!errorText.isEmpty) {
                errorMessage
            }
            if(checkStrength) {
                PasswordStrengthView(passwordStrength: $passwordStrength, passwordTxt: $txt)
            }
        }
//        .initKeyboardForPage(
//            textsInPage:
//                [
//                    .init(
//                        text: $txt
//                        , focusField: .phone
//                        , isHidden: $isSecured
//                    )
//                ]
//        )
    }
    
    @State var passwordStrength = PasswordStrength.Weak
    
    @ViewBuilder var errorMessage : some View {
        Text(errorText)
            .foregroundColor(msViews.viewsHelper.errorColor)
            .font(.custom(getAppFont(textWeight), size: textSize).weight(textWeight))
    }
    
    @ViewBuilder var oneLineField : some View {
        textField
            .foregroundStyle(textColor)
            .font(.custom(getAppFont(textWeight), size: textSize).weight(textWeight))
            .padding(.horizontal , padding)
            .frame(height: height)
            .background(
                RoundedRectangle(cornerRadius: radius)
                    .stroke(
                        style: .init(lineWidth: 1, lineCap: .butt, lineJoin: .bevel, miterLimit: 1, dash: [1,0], dashPhase: 0))
                    .fill(
                        getBorderColor()
                    )
                    .background(
                        RoundedRectangle(cornerRadius: radius)
                            .fill(fieldBackgroundColor)
                    )
            )
            .overlay(alignment: .trailing) {
                if(isPassword) {
                    CustomImage(isSecured ? "password_eye_closed" : "password_eye")
                        .padding(.trailing , passIconPadding)
                        .onTapGesture {
                            isSecured.toggle()
                        }
                }
            }
            .keyboardType(type)
            .submitLabel(submitLabel)
            .onSubmit {
                if let submit = onSubmit {
                    submit(txt)
                }
            }
            .disabled(disabled)
    }
    
    @ViewBuilder var textField : some View {
        let textBinding = Binding<String>(get: {
            self.txt
        }, set: {
            self.txt = $0
            if let onTxtChange = onTextChange {
                if(checkStrength) {
                    passwordStrength = checkPasswordStrength(txt)
                }
                onTxtChange($0)
            }
        })
        if ( isPassword && isSecured ) {
            SecureField(placeHolder , text: textBinding)
        } else {
//            TextField(placeHolder , text: textBinding)
            TextField("", text: textBinding, prompt: Text(placeHolder).font(.custom(getAppFont(textWeight), size: textSize).weight(textWeight)).foregroundColor(placeHolderColor))
        }
    }
    
    func getBorderColor() -> Color {
        if(errorText.isEmpty && !hasError){
            if(shouldHasBorder) {
                return borderColor
            } else {
                return .clear
            }
        } else {
            return msViews.viewsHelper.errorColor
        }
    }
    
    public enum PasswordStrength {
        case VeryStrong
        case Strong
        case Medium
        case Weak
    }
    
    public func checkPasswordStrength(_ password: String) -> PasswordStrength {
        var score = 0
        
        // Check for the presence of different character types
        let hasUppercase = password.rangeOfCharacter(from: .uppercaseLetters) != nil
        let hasLowercase = password.rangeOfCharacter(from: .lowercaseLetters) != nil
        let hasDigit = password.rangeOfCharacter(from: .decimalDigits) != nil
        let hasSpecialCharacter = password.rangeOfCharacter(from: CharacterSet(charactersIn: "!@#$%^&*()-_=+[]{}|;:'\",.<>?/")) != nil
        
        // Assign scores based on the criteria
        if hasUppercase {
            score += 2
        }
        if hasLowercase {
            score += 2
        }
        if hasDigit {
            score += 2
        }
        if hasSpecialCharacter {
            score += 2
        }
        
        // Check the total length of the password and assign a score
        let length = password.count
        if length >= 8 {
            score += 2
        } else if length >= 12 {
            score += 4
        }
        
        // Determine the password strength level based on the score
        switch score {
        case 8...10:
            return .VeryStrong
        case 6...7:
            return .Strong
        case 4...5:
            return .Medium
        default:
            return .Weak
        }
    }
}

struct OneLineFieldPreviewHelper : View {
    @State var txt:String = ""
    @State var errorText : String = "sss"
    var body: some View {
        ZStack {
            Color.gray
            OneLineField(
                txt: $txt, errorText: $errorText, placeHolder: "Place holder" , shouldHasBorder: true , hasError:false) { _ in} onTextChange: { _ in}
        }
    }
}

struct OneLineField_Previews: PreviewProvider {
    static var previews: some View {
        OneLineFieldPreviewHelper()
    }
}

struct PasswordStrengthView : View {
    @State var strenghText = ""
    @Binding var passwordStrength : OneLineField.PasswordStrength
    @Binding var passwordTxt : String
    
    var body: some View {
        VStack(alignment:.leading , spacing:0) {
            if(!passwordTxt.isEmpty) {
                HStack(spacing:5){
                    rect
                    rect.opacity((passwordStrength == .Medium || passwordStrength == .Strong || passwordStrength == .VeryStrong) ? 1 : 0)
                    rect.opacity((passwordStrength == .Strong || passwordStrength == .VeryStrong) ? 1 : 0)
                    rect.opacity(passwordStrength == .VeryStrong ? 1 : 0)
                }
                .padding(.top, 3)
                .foregroundColor(
                    getStrengthColor()
                )
                getStrengthText()
            }
        }
    }
    
    var rect : some View {
        RoundedRectangle(cornerRadius: 2)
            .frame(width: 30, height: 4)
    }
    
    func getStrengthColor() -> Color {
        if(passwordStrength == .Weak) {
            return .red
        } else if (passwordStrength == .Medium){
            return .orange
        } else if (passwordStrength == .Strong){
            return .green.opacity(0.6)
        } else {
            return .green
        }
    }
    
    func getStrengthText() -> some View {
        if(passwordStrength == .Weak) {
            return Text("Password is weak")
                .foregroundColor(.red)
        } else if (passwordStrength == .Medium){
            return Text("Password is medium")
                .foregroundColor(.orange)
        } else if (passwordStrength == .Strong){
            return Text("Password is strong")
                .foregroundColor(.green.opacity(0.6))
        } else {
            return Text("Password is very strong")
                .foregroundColor(.green)
        }
    }
}

public struct KeyboardToolBar : ViewModifier {
    @Binding public var txt : String
    
    public func body(content: Content) -> some View {
        content
            .toolbar(content: {
                ToolbarItem(placement: .keyboard) {
                    HStack{
                        ScrollView(.horizontal){
                            Text(txt)
                                .lineLimit(3)
                        }
                        Spacer()
                        LoadingButton(
                            myState: .constant(.Enabled)
                            , width: 50
                            , height: 30
                            , isInverted: false
                            , buttonText: "Done"
                            , buttonImage: ""
                            , fontWeight: .medium
                            , radius: 10) {
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }
                            .textStyle(.custom, size: 10, lineSpacing: 5, monoSpacing: 0, fontWeight: .medium)
                    }
                }
            })
    }
}

extension View {
    public func keyboardToolBar(_ text:Binding<String>) -> some View {
        modifier(KeyboardToolBar(txt: text))
    }
}
