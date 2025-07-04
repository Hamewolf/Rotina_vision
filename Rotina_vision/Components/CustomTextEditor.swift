//
//  CustomTextEditor.swift
//  Carrier Beyond
//
//  Created by Pedro Warol on 13/01/25.
//

import SwiftUI
import UIKit

struct CustomTextEditor: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textColor = UIColor.black
        textView.backgroundColor = UIColor(named: "customCard")
        textView.layer.cornerRadius = 15
//        textView.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        textView.text = placeholder // Define o placeholder inicial

        // Adiciona a toolbar com o botão "Fechar"
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let closeButton = UIBarButtonItem(
            title: "Fechar",
            style: .done,
            target: context.coordinator,
            action: #selector(context.coordinator.dismissKeyboard)
        )
        toolbar.items = [UIBarButtonItem.flexibleSpace(), closeButton]
        textView.inputAccessoryView = toolbar

        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        if text.isEmpty && !uiView.isFirstResponder {
            uiView.text = placeholder
            uiView.textColor = UIColor.black
        } else if !text.isEmpty {
            uiView.text = text
            uiView.textColor = UIColor(named: "customWhite")
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextViewDelegate {
        var parent: CustomTextEditor

        init(_ parent: CustomTextEditor) {
            self.parent = parent
        }

        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.text == parent.placeholder {
                textView.text = ""
                textView.textColor = UIColor(named: "customWhite")
            }
        }

        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text.isEmpty {
                textView.text = parent.placeholder
                textView.textColor = UIColor.black
            }
            parent.text = textView.text
        }

        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }

        @objc func dismissKeyboard() {
            // Fecha o teclado
            UIApplication.shared.sendAction(
                #selector(UIResponder.resignFirstResponder),
                to: nil,
                from: nil,
                for: nil
            )
        }
    }
}
