//
//  CustomSecureField.swift
//  Rotina_vision
//
//  Created by Mohamad Lobo on 18/03/25.
//

import SwiftUI

struct CustomSecureField: View {
    
    var placeholder: String
    var padding: Double
    @Binding var text: String
    @Binding var eyeAction : Bool
    var textColor : Color
    var textFieldColor : Color
    var frameWidht : Double
    var frameHeight : Double
    var cornerRadius : Double
    var lineWidth : Double
    var fontSize : Double
    var lineOpacity : Double
    var eyeColor : Color
    var backgroundColor : Color
    
    var body: some View {
        ZStack(alignment: .leading) {
            if eyeAction == false {
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundColor(textColor)
                        .padding(.leading, padding)
                        .font(.system(size: fontSize))
                        .padding(.trailing, 6)
                }
                SecureField("", text: $text)
                    .foregroundColor(textFieldColor)
                    .padding(.leading, padding)
                    .font(.system(size: fontSize))
                    .padding(.trailing, 6)
                    .overlay (
                        Button {
                            eyeAction.toggle()
                        } label: {
                            Image(systemName: "eye")
                                .padding(.trailing)
                                .foregroundColor(eyeColor)
                        }
                        , alignment: .trailing)
            } else {
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundColor(textColor)
                        .padding(.leading, padding)
                        .font(.system(size: fontSize))
                        .padding(.trailing, 6)
                }
                TextField("", text: $text)
                    .foregroundColor(textFieldColor)
                    .padding(.leading, padding)
                    .font(.system(size: fontSize))
                    .padding(.trailing, 6)
                    .overlay (
                        Button {
                            eyeAction.toggle()
                        } label: {
                            Image(systemName: "eye.slash")
                                .padding(.trailing)
                                .foregroundColor(eyeColor)
                        }
                        , alignment: .trailing)
            }
        }
        .frame(height: frameHeight)
        .frame(maxWidth: frameWidht)
        .background(
            RoundedRectangle(cornerRadius: cornerRadius)
                .foregroundColor(backgroundColor)
        )
    }
}
