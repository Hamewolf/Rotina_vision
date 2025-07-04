//
//  CustomPicker.swift
//  Carrier Beyond
//
//  Created by Pedro Warol on 08/11/24.
//

import Foundation
import SwiftUI

struct CustomPicker: UIViewRepresentable {
    
    private let textField = UITextField()
    private let pickerView = UIPickerView()
    private let helper = Helper()
    
    var data: [String]
    var placeholder: String
    
    @Binding var lastSelectedIndex: Int?

    func makeUIView(context: Context) -> UITextField {
        self.pickerView.delegate = context.coordinator
        self.pickerView.dataSource = context.coordinator
        context.coordinator.pickerView = self.pickerView // Passa a referência do pickerView para o coordinator
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        
        self.textField.placeholder = self.placeholder
        self.textField.inputView = self.pickerView
        self.textField.leftView = leftView
        self.textField.leftViewMode = .always
        self.textField.textColor = .black
        
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 16)
        ]
        textField.attributedPlaceholder = NSAttributedString(string: self.placeholder, attributes: placeholderAttributes)
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Close", style: .plain, target: self.helper, action: #selector(self.helper.doneButtonAction))
        toolBar.setItems([flexibleSpace, doneButton], animated: true)
        self.textField.inputAccessoryView = toolBar
        
        self.helper.doneButtonTapped = {
            if self.lastSelectedIndex == nil, !self.data.isEmpty {
                self.lastSelectedIndex = 0
            }
            self.textField.resignFirstResponder()
        }
        
        return self.textField
    }
 
    func updateUIView(_ uiView: UITextField, context: Context) {
        // Atualiza os dados no Coordinator
        context.coordinator.data = self.data
        context.coordinator.pickerView?.reloadAllComponents() // Garante que os dados mais recentes sejam carregados
        
        if let lastSelectedIndex = self.lastSelectedIndex, lastSelectedIndex < self.data.count {
            uiView.text = self.data[lastSelectedIndex]
            context.coordinator.pickerView?.selectRow(lastSelectedIndex, inComponent: 0, animated: false)
        }
    }
    
    func makeCoordinator () -> Coordinator {
        return Coordinator(data: self.data) { index in
            self.lastSelectedIndex = index
        }
    }
    
    class Helper {
        public var doneButtonTapped : (() -> Void)?
        
        @objc func doneButtonAction() {
            self.doneButtonTapped?()
        }
    }

    class Coordinator: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
        
        var pickerView: UIPickerView?
        var data: [String]
        private var didSelectItem: ((Int) -> Void)?
        
        init(data: [String], didSelectItem: ((Int) -> Void)? = nil) {
            self.data = data
            self.didSelectItem = didSelectItem
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return data.count
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return data[row]
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            self.didSelectItem?(row)
        }
    }
}

struct CustomMorePicker: UIViewRepresentable {
    
    private let textField = UITextField()
    private let pickerView = UIPickerView()
    private let helper = Helper()
    
    var dataSources: [[String]] // Agora aceita múltiplos componentes
    var placeholder: String
    var numberOfComponents: Int // Número opcional de componentes
    
    @Binding var selectedIndices: [Int?] // Agora selecionamos múltiplos índices
    
    func makeUIView(context: Context) -> UITextField {
        self.pickerView.delegate = context.coordinator
        self.pickerView.dataSource = context.coordinator
        context.coordinator.pickerView = self.pickerView
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        
        self.textField.placeholder = self.placeholder
        self.textField.inputView = self.pickerView
        self.textField.leftView = leftView
        self.textField.leftViewMode = .always
        self.textField.textColor = .black
        
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 16)
        ]
        textField.attributedPlaceholder = NSAttributedString(string: self.placeholder, attributes: placeholderAttributes)
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Close", style: .plain, target: self.helper, action: #selector(self.helper.doneButtonAction))
        toolBar.setItems([flexibleSpace, doneButton], animated: true)
        self.textField.inputAccessoryView = toolBar
        
        self.helper.doneButtonTapped = {
            for (index, data) in self.dataSources.enumerated() {
                if self.selectedIndices[index] == nil, !data.isEmpty {
                    self.selectedIndices[index] = 0
                }
            }
            self.textField.resignFirstResponder()
        }
        
        return self.textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        context.coordinator.dataSources = self.dataSources
        context.coordinator.numberOfComponents = self.numberOfComponents
        context.coordinator.pickerView?.reloadAllComponents()
        
        // Atualizar seleção dos componentes
        var selectedTexts: [String] = []
        for (index, selectedIndex) in self.selectedIndices.enumerated() {
            if let selectedIndex = selectedIndex, selectedIndex < self.dataSources[index].count {
                selectedTexts.append(self.dataSources[index][selectedIndex])
                context.coordinator.pickerView?.selectRow(selectedIndex, inComponent: index, animated: false)
            }
        }
        uiView.text = selectedTexts.joined(separator: "")
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(dataSources: self.dataSources, numberOfComponents: self.numberOfComponents, selectedIndices: $selectedIndices)
    }
    
    class Helper {
        public var doneButtonTapped: (() -> Void)?
        
        @objc func doneButtonAction() {
            self.doneButtonTapped?()
        }
    }
    
    class Coordinator: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
        
        var pickerView: UIPickerView?
        var dataSources: [[String]]
        var numberOfComponents: Int
        @Binding var selectedIndices: [Int?] // Agora utilizamos @Binding para atualizar corretamente
        
        init(dataSources: [[String]], numberOfComponents: Int, selectedIndices: Binding<[Int?]>) {
            self.dataSources = dataSources
            self.numberOfComponents = numberOfComponents
            self._selectedIndices = selectedIndices
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return numberOfComponents
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return dataSources[component].count
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return dataSources[component][row]
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            selectedIndices[component] = row
        }
    }
}

struct CustomPickerBlackText: UIViewRepresentable {
    
    private let textField = UITextField()
    private let pickerView = UIPickerView()
    private let helper = Helper()
    
    var data: [String]
    var placeholder: String
    
    @Binding var lastSelectedIndex: Int?

    func makeUIView(context: Context) -> UITextField {
        self.pickerView.delegate = context.coordinator
        self.pickerView.dataSource = context.coordinator
        context.coordinator.pickerView = self.pickerView // Passa a referência do pickerView para o coordinator
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        
        self.textField.placeholder = self.placeholder
        self.textField.inputView = self.pickerView
        self.textField.leftView = leftView
        self.textField.leftViewMode = .always
        self.textField.textColor = .black
        
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 16)
        ]
        textField.attributedPlaceholder = NSAttributedString(string: self.placeholder, attributes: placeholderAttributes)
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Close", style: .plain, target: self.helper, action: #selector(self.helper.doneButtonAction))
        toolBar.setItems([flexibleSpace, doneButton], animated: true)
        self.textField.inputAccessoryView = toolBar
        
        self.helper.doneButtonTapped = {
            if self.lastSelectedIndex == nil, !self.data.isEmpty {
                self.lastSelectedIndex = 0
            }
            self.textField.resignFirstResponder()
        }
        
        return self.textField
    }
 
    func updateUIView(_ uiView: UITextField, context: Context) {
        // Atualiza os dados no Coordinator
        context.coordinator.data = self.data
        context.coordinator.pickerView?.reloadAllComponents() // Garante que os dados mais recentes sejam carregados
        
        if let lastSelectedIndex = self.lastSelectedIndex, lastSelectedIndex < self.data.count {
            uiView.text = self.data[lastSelectedIndex]
            context.coordinator.pickerView?.selectRow(lastSelectedIndex, inComponent: 0, animated: false)
        }
    }
    
    func makeCoordinator () -> Coordinator {
        return Coordinator(data: self.data) { index in
            self.lastSelectedIndex = index
        }
    }
    
    class Helper {
        public var doneButtonTapped : (() -> Void)?
        
        @objc func doneButtonAction() {
            self.doneButtonTapped?()
        }
    }

    class Coordinator: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
        
        var pickerView: UIPickerView?
        var data: [String]
        private var didSelectItem: ((Int) -> Void)?
        
        init(data: [String], didSelectItem: ((Int) -> Void)? = nil) {
            self.data = data
            self.didSelectItem = didSelectItem
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return data.count
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return data[row]
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            self.didSelectItem?(row)
        }
    }
}

