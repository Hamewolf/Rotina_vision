//
//  avatarView.swift
//  Rotina_vision
//
//  Created by Mohamad Lobo on 08/04/25.
//

import SwiftUI

struct AvatarView: View {
    var body: some View {
        ZStack {
            Color.gray.opacity(0.5).ignoresSafeArea()
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Image(.avatar)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                }
                .overlay(
                    VStack {
                        HStack {
                            // Balão de fala
                            Text("Olá! 👋\nBem vindo ao Rotina vision")
                                .foregroundStyle(.black)
                                .padding(10)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.white)
                                        .shadow(radius: 2)
                                )
                        }
                        
                        Spacer()
                    }
                        .frame(width: 130)
                    , alignment: .top
                )
            }
        }
    }
}

#Preview {
    AvatarView()
}

