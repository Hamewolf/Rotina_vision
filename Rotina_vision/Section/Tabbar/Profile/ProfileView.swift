//
//  ProfileView.swift
//  Rotina_vision
//
//  Created by Mohamad Lobo on 09/04/25.
//

import SwiftUI

struct ProfileView: View {
    @State private var name: String = "Mohamad"
    @State private var email: String = "a@a.com"
    @State private var password: String = "a"

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .foregroundColor(.gray)
                    .padding(.top, 40)

                VStack(alignment: .leading, spacing: 12) {
                    Text("Nome")
                        .font(.caption)
                        .foregroundColor(.gray)
                    TextField("Nome", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    Text("Email")
                        .font(.caption)
                        .foregroundColor(.gray)
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.emailAddress)

                    Text("Senha")
                        .font(.caption)
                        .foregroundColor(.gray)
                    SecureField("Senha", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(.horizontal)

                Button(action: {
                    print("Trocar senha clicado")
                }) {
                    Text("Trocar Senha")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .padding(.top, 10)

                Spacer()
            }
            .navigationTitle("Perfil")
        }
    }
}

#Preview {
    ProfileView()
}

