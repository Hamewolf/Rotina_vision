//
//  CustomButton.swift
//  Rotina_vision
//
//  Created by Mohamad Lobo on 18/03/25.
//

import SwiftUI

struct CustomButton: View {
    // MARK: - PROPERTY
    var cornerRadius: Double
    var foregroundColor: Color
    var width: Double
    var height: Double
    var text: String
    var borderColor: Color
    var hasBorder: Bool = false
    var borderWidth : Double
    var textColor : Color
    var action: () -> Void
    
    // MARK: - BODY
    var body: some View {
        Button {
            action()
        } label: {
            RoundedRectangle(cornerRadius: cornerRadius)
                .foregroundColor(foregroundColor)
                .frame(maxWidth: width)
                .frame(height: height)
                .overlay(
                    Text(text)
                        .font(.system(size: 16))
                        .foregroundColor(textColor),
                    alignment: .center
                )
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(borderColor, lineWidth: hasBorder ? borderWidth : 0)
                )
        }
    }
}
