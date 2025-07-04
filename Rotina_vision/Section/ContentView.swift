//
//  ContentView.swift
//  Rotina_vision
//
//  Created by Mohamad Lobo on 11/03/25.
//

import SwiftUI

struct ContentView: View {
    
    //MARK: - PROPERTY -
    
    @State private var email : String = ""
    @State private var password : String = ""
    @State private var eyeAction : Bool = false
    @State private var isNavigate : Bool = false
    @State private var showAlert : Bool = false
    @State private var error : String = ""
    @State private var isLoading : Bool = false
    @State private var stayLogged : Bool = false
    
    //MARK: - BODY
    var body: some View {
        NavigationStack{
            ZStack {
                Color.customBackground.ignoresSafeArea()
                VStack(alignment: .center) {
                    
                    Image(.logo)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250)
                    
                    VStack(alignment: .leading, spacing: 30) {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Email")
                                .multilineTextAlignment(.leading)
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                            
                            CustomTextField(placeholder: "Email", padding: 12, text: $email, textColor: .white, textFieldColor: .white, frameWidth: .infinity, frameHeight: 45, cornerRadius: 6, lineWidth: 0.3, fontSize: 16, opacity: 1, backgroundColor: .customBlue, hasBorder: false, keyboardType: .emailAddress) {
                            }
                            .autocapitalization(.none)
                            
                        }
                        .padding(.horizontal)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            
                            Text("Senha")
                                .multilineTextAlignment(.leading)
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                            
                            CustomSecureField(placeholder: "Senha", padding: 12, text: $password, eyeAction: $eyeAction, textColor: .white, textFieldColor: .white, frameWidht: .infinity, frameHeight: 45, cornerRadius: 6, lineWidth: 0.3, fontSize: 16, lineOpacity: 1, eyeColor: .white, backgroundColor: .customBlue)
                            
                        }
                        .padding(.horizontal)
                        
                    }//:VSTACK TEXTFIELDS
                    
                    
                    HStack {
                        Toggle("", isOn: $stayLogged)
                            .frame(width: 40)
                            .toggleStyle(SwitchToggleStyle(tint: .customDarkBlue))
                        
                        Text("Manter-se conectado")
                            .font(.system(size: 12))
                            .padding(.leading)
                        
                        Spacer()
                        
                        NavigationLink {
                            ForgotPasswordView()
                        } label: {
                            Text("Esqueci minha senha")
                                .foregroundColor(.white)
                                .font(.system(size: 12))
                                .underline()
                        }
                        
                    }//:HSTACK TEXT
                    .padding(.horizontal)
                    .padding(.top)
                    
                    HStack {
                        Spacer()
                        VStack {
                            CustomButton(cornerRadius: 30, foregroundColor: .customBlue, width: .infinity, height: 45, text: "Login", borderColor: .customDarkBlue, hasBorder: false, borderWidth: 2, textColor: .white) {
                                if email.isEmpty && password.isEmpty {
                                    showAlert = true
                                    error = "É necessário preencher todas os campos"
                                } else if email != "a@a.com" || password != "a"{
                                    showAlert = true
                                    error = "e-mail ou senha errados"
                                } else {
                                    isNavigate = true
                                }
                            }
                            HStack {
                                Text("Don’t have an account?")
                                    .font(.system(size: 14))
                                    .foregroundColor(.white)
                                
                                Text("Sign Up!")
                                    .font(.system(size: 14))
                                    .foregroundColor(.customLightBlue)
                                    .underline()
                            }
                            .padding(.top, 5)
                        }
                        Spacer()
                    }//:HSTACK BUTTON AND REGISTER TEXT
                    .padding(.top, 60)
                    .padding(.horizontal, 40)
                    Spacer()
                }//:VSTACK GLOBAL
                .padding(.top)
            }//:ZSTACK
            .preferredColorScheme(.dark)
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text(error),
                    dismissButton: .default(Text("OK"))
                )
            }
            .fullScreenCover(isPresented: $isNavigate) {
                TabBarController()
            }
        }
    }
}

#Preview {
    ContentView()
}
