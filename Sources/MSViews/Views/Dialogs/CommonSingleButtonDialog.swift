////
////  CommonPage.swift
////  VisionDimensions
////
////  Created by Corptia 02 on 07/05/2023.
////
//
//import SwiftUI
//import msViews
//
//struct CommonSingleButtonDialog<Content : View>: View {
//    @State var dialogBtnState : ButtonState = .Enabled
//    @Binding var showDialog : Bool
//    
//    var content : Content
//    var btnTitle : ProjectStrings
//    var onDismiss : (()->Void)! = nil
//    var onClick : (()->Void)! = nil
//    var dismissByClick : Bool = false
//    var hasCloseImg : Bool = true
//    var shouldStayActive : Bool = true
//    
//    init (
//        btnTitle: ProjectStrings = .non,
//        dismissByClick:Bool = false,
//        hasCloseImg : Bool = false ,
//        showDialog:Binding<Bool>,
//        onDismiss : @escaping () -> Void ,
//        onClick : @escaping () -> Void ,
//        @ViewBuilder content: () -> Content
//    ) {
//        self._showDialog = showDialog
//        self.content = content()
//        self.dismissByClick = dismissByClick
//        self.onDismiss = onDismiss
//        self.onClick = onClick
//        self.btnTitle = btnTitle
//        self.hasCloseImg = hasCloseImg
//    }
//    
//    var body: some View {
//        ZStack(alignment: .center){
//            BlurView()
//                .onTapGesture {
//                    if(dismissByClick) {
//                        showDialog = false
//                    }
//                }
//            VStack{
//                if(hasCloseImg) {
//                    HStack {
//                        Spacer()
//                        CustomImage(img: .close)
//                            .frame(width: 30, height: 30)
//                            .padding(.trailing , -12)
//                            .onTapGesture {
//                                showDialog = false
//                            }
//                    }
//                }
//                content
//                CustomNavLink.init(
//                    btnState: $dialogBtnState,
//                    btnWidth: .infinity,
//                    navTitle: strings(key: btnTitle, preName: .button),
//                    content: {} ,
//                    onNavClicked: {
//                        onClick()
//                        if(shouldStayActive) {
//                            dialogBtnState = .Enabled
//                        }
//                    }
//                )
//                .appTextStyle(.btn)
//            }
//            .padding(.horizontal, 36 + 36)
//            .padding(.vertical, 24)
//            .background(
//                RoundedRectangle(cornerRadius: 8)
//                    .fill(.white)
//                    .frame(
//                        width: helper.viewsHelper.screenWidth() - (36.0 * 2.0)
//                    )
//            )
//        }
//        .onAppear {
//            dialogBtnState = .Enabled
//        }
//        .onDisappear {
//            if let dismiss = onDismiss {
//                dismiss()
//            }
//        }
//        .ignoresSafeArea()
//    }
//}
//
//fileprivate struct CommonSingleButtonDialogHelper : View{
//    @State var showDialog = true
//    var body: some View {
//        CommonSingleButtonDialog(showDialog: $showDialog) {
//            
//        } onClick: {
//            
//        }
//        content :{
//            Text("Hello, World!")
//        }
//    }
//}
//
//struct CommonSingleButtonDialog_Previews: PreviewProvider {
//    static var previews: some View {
//        CommonSingleButtonDialogHelper()
//    }
//}
