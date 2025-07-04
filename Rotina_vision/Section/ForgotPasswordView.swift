//
//  ForgotPasswordView.swift
//  Rotina_vision
//
//  Created by Mohamad Lobo on 18/03/25.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    //MARK: - PROPERTY
    
    @State private var email : String = ""
    @State private var isAnimated : Bool = false
    @State private var isLoading : Bool = false
    @State private var showAlert : Bool = false
    @State private var error : String = ""
    @Environment(\.presentationMode) var presentationMode
        
    
    //MARK: - BODY
    var body: some View {
        ZStack {
            Color.customBackground.ignoresSafeArea()
            VStack(alignment: .leading) {
                
                Text("Enter your e-mail address to reset your password")
                    .font(.system(size: 18))
                    .foregroundColor(.white)
                    .padding(.bottom)
                    .padding(.leading)
                
                VStack(alignment: .leading, spacing: 10) {
                    CustomTextField(placeholder: "Email", padding: 12, text: $email, textColor: .white, textFieldColor: .white, frameWidth: .infinity, frameHeight: 45, cornerRadius: 6, lineWidth: 0.8, fontSize: 16, opacity: 1, backgroundColor: .clear, hasBorder: true, keyboardType: .emailAddress, lineColor: .customDarkBlue) {
                        //
                    }
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .padding(.horizontal)
                }
                
                HStack {
                    Spacer()
                    VStack(spacing: 15) {
                        Button {
                            //
                        } label: {
                            RoundedRectangle(cornerRadius: 25)
                                .foregroundColor(.customDarkBlue)
                                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                                .frame(height: 45)
                                .overlay(
                                    Text("Send")
                                        .font(.system(size: 16))
                                        .foregroundColor(.white), alignment: .center)
                                .padding(.horizontal, 45)
                        }
                    }
                    .padding(.top)
                    Spacer()
                }//:HSTACK INFOS
                Spacer()
            }//:VSTACK GLOBAL
        }//:ZSTACK
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(error),
                dismissButton: .default(Text("OK"))
            )
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.3)) {
                isAnimated = true
            }
        }
    }
}

#Preview {
    ForgotPasswordView()
}
