//
//  CustomTextField.swift
//  Rotina_vision
//
//  Created by Mohamad Lobo on 18/03/25.
//

import SwiftUI

struct CustomTextField: View {
    var placeholder: String
    var padding: Double
    @Binding var text: String
    var textColor: UIColor
    var textFieldColor: Color
    var frameWidth: Double
    var frameHeight: Double
    var cornerRadius: Double
    var lineWidth: Double
    var fontSize: Double
    var opacity: Double
    var backgroundColor: Color
    var hasBorder: Bool
    var keyboardType: UIKeyboardType
    var returnKeyboardType: UIReturnKeyType?
    var autocapitalizationType: UITextAutocapitalizationType?
    var lineColor : Color?
    var onCommit: () -> Void
    var doneButtonAction: (() -> Void)? // Tornar opcional
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(Color(textColor))
                    .padding(.leading, padding)
                    .font(.system(size: fontSize))
                    .padding(.trailing, 6)
            }
            TextField("", text: $text)
            .foregroundColor(textFieldColor)
            .keyboardType(keyboardType)
            .padding(.leading, padding)
            .font(.system(size: fontSize))
            .padding(.trailing, 6)
        }
        .frame(height: frameHeight)
        .frame(maxWidth: frameWidth)
        .background(
            RoundedRectangle(cornerRadius: cornerRadius)
                .foregroundColor(backgroundColor.opacity(opacity))
                .overlay(
                    hasBorder ?
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(lineColor ?? .clear, lineWidth: lineWidth)
                    : nil
                )
        )
    }
}
