//
//  KeyboardToolBar.swift
//  
//
//  Created by Moha on 01/06/2024.
//
import SwiftUI

public struct KeyboardModifier : ViewModifier {
    @State var textsInPage : [Binding<String>] = .init()
    @State var textsSecure : [Binding<Bool>] = .init()
    @State var keys : [FieldToFocus] = .init()
    @State var focusState : EquatableFocusState? = nil
    
    var txt : Binding<String> {
        get {
            if let focusState {
//                print("FOCUS STATE : ALL KEYS" , keys.map({ f in
//                    return f
//                }))
                if let fieldState = focusState.focusField {
                    if let field = fieldState.wrappedValue {
//                        print("FOCUS STATE : field" , field)
//                        let i = keys.firstIndex { f in
//                             f == field
//                        }
//                        print("FOCUS STATE : field , i , " , i)
                        if let k = keys.firstIndex(of: field) {
                            let isSecured = textsSecure[k].wrappedValue
                            let currentText = textsInPage[k]
                            let securedText = self.maskString(currentText.wrappedValue)
                            let securedBText = Binding<String>.init {
                                return securedText
                            } set: { _ in
                                
                            }
//                            print("FOCUS STATE : TEXT" , currentText)
                            return isSecured ? securedBText : currentText
                        }
                    }
                }
            }
            return .constant("")
        }
    }
    
    public func body(content: Content) -> some View {
        content
            .toolbar(content: {
                ToolbarItem(placement: .keyboard) {
                    HStack{
                        ScrollView(.horizontal){
                            Text(txt.wrappedValue)
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
                            , radius: 10
                        ) {
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
                        .textStyle(.custom, size: 10, lineSpacing: 5, monoSpacing: 0, fontWeight: .medium)
                    }
                }
            })
            .onPreferenceChange(KeyboardTextsPrefKey.self, perform: { value in
                self.textsInPage = value.map { $0.text }
                self.keys = value.map { $0.focusField }
                self.textsSecure = value.map { $0.isHidden }
            })
//            .onPreferenceChange(KeyboardTextPrefKey.self, perform: { value in
//                if let value {
//                    if(!self.keys.contains(where: { f in
//                        return f == value.focusField
//                    })) {
//                        self.textsInPage.append(value.text)
//                        self.keys.append(value.focusField)
//                        self.textsSecure.append(value.isHidden)
//                    }
//                }
//                
//            })
            .onPreferenceChange(KeyboardFieldPrefKey.self, perform: { value in
                if let field = value {
                    self.focusState = field
                }
            })
    }
    
    func maskString(_ input: String) -> String {
        return String(repeating: "*", count: input.count)
    }
}

public struct KeyboardTextsPrefKey : PreferenceKey {
    public static func reduce(value: inout [EquatableBinding], nextValue: () -> [EquatableBinding]) {
        value.append(contentsOf: nextValue())
    }
    
    public static var defaultValue: [EquatableBinding] = .init()
}

public struct KeyboardTextPrefKey : PreferenceKey {
    public static func reduce(value: inout EquatableBinding?, nextValue: () -> EquatableBinding?) {
        value = nextValue() ?? value
    }
    
    public static var defaultValue: EquatableBinding? = nil
}

public struct KeyboardFieldPrefKey: PreferenceKey {
    public static func reduce(value: inout EquatableFocusState?, nextValue: () -> EquatableFocusState?) {
        value = nextValue() ?? value
    }

    public static var defaultValue: EquatableFocusState? = nil
}

public class EquatableBinding : Equatable {
    let id = UUID().uuidString
    
    public static func == (lhs: EquatableBinding, rhs: EquatableBinding) -> Bool {
        return (lhs.id == rhs.id) && (lhs.focusField == rhs.focusField)
    }
    
    let text : Binding<String>
    let focusField : FieldToFocus
    let isHidden : Binding<Bool>
    
    public init(
        text: Binding<String>
        , focusField : FieldToFocus
        , isHidden: Binding<Bool>? = nil
    ) {
        self.text = text
        self.focusField = focusField
        self.isHidden = isHidden ?? .constant(false)
    }
}

public class EquatableFocusState: Equatable {
    let id = UUID().uuidString
    public static func == (lhs: EquatableFocusState, rhs: EquatableFocusState) -> Bool {
        return lhs.id == rhs.id && lhs.focusField?.wrappedValue == rhs.focusField?.wrappedValue
    }

    var focusField: FocusState<FieldToFocus?>?

    public init(focusField: FocusState<FieldToFocus?>?) {
        self.focusField = focusField
    }
}

public extension View {
    func initKeyboardToolbar() -> some View{
        self.modifier(KeyboardModifier())
    }
    
    func initKeyboardForPage(
         textsInPage : [EquatableBinding]
    )-> some View{
        self
            .preference(key: KeyboardTextsPrefKey.self, value: textsInPage)
    }
    
    func addValuesToKeyboard (
         text : EquatableBinding
    )-> some View{
        self
            .preference(key: KeyboardTextPrefKey.self, value: text)
    }
    
    func initFieldForKeyboard(
        focusState : EquatableFocusState?
    )-> some View{
        self
            .preference(key: KeyboardFieldPrefKey.self, value: focusState)
//            .onAppear(perform: {
//                print("TEST KEYBOARD , state" , focusState)
//            })
    }
}

public enum FieldToFocus {
    case nothing
    case phone
    case password
    case confirm_password
    case new_password
    case name
    case firstName
    case lastName
    case city
    case carType
    
    case addressNick
    case addressDetails
    case addressBuilding
    case addressFloor
    case addressApartment
    case addressAdditionalInfo
    
    
    case department
    case arabicName
    case englishName
    case arabicDesc
    case englishDesc
    case price
    case priceBefore
    case priceAfter
    case conditions
    case dateStart
    case dateEnd
    
    case locationOnMap
    case whatsappNum
    
    
    
    case field_1
    case field_2
    case field_3
    case field_4
    case field_5
    case field_6
    case field_7
    case field_8
    case field_9
    case field_10
    case field_11
    case field_12
    case field_13
    case field_14
    case field_15
    case field_16
    case field_17
    case field_18
    case field_19
    case field_20
    
    case dynamicIndex(Int)
    
    static func dynamicField(_ index: Int) -> FieldToFocus {
            return .dynamicIndex(index)
    }
}
