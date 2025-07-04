//
//  TabBarController.swift
//  Rotina_vision
//
//  Created by Mohamad Lobo on 18/03/25.
//

import SwiftUI

struct TabBarController: View {
    //MARK: - PROPERTY
    
    @State private var showAvatar : Bool = true
    
    var body: some View {
        NavigationStack{
            ZStack {
                TabView {
                    HomeView()
                        .tabItem {
                            Label("Home", systemImage: "house")
                        }
                    
                    ProfileView()
                        .tabItem {
                            Label("Perfil", systemImage: "person.fill")
                        }
                }
                .opacity(showAvatar ? 0.2 : 1)
                if showAvatar {
                    AvatarView()
                        .onTapGesture {
                            showAvatar = false
                        }
                }
            }
            
            .accentColor(.customLightBlue)
        }
    }
}

#Preview {
    TabBarController()
}
