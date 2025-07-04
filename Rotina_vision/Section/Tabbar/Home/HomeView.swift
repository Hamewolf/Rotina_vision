//
//  HomeView.swift
//  Rotina_vision
//
//  Created by Mohamad Lobo on 18/03/25.
//

import SwiftUI

struct HomeView: View {
    
    // MARK: - PROPERTIES
    @State private var selectedDate = Date()
    @State private var tasks: [Task] = (0..<24).map {
        Task(hourDayString: String(format: "%02d:00", $0))
    }
    @State private var showingDatePicker = false
    @State private var showingBottomSheet = false

    // Campos do BottomSheet de tarefa
    @State private var newTaskHour: Int? = nil
    @State private var newTaskName = ""
    @State private var newTaskDescription = ""
    
    private let horasDisponiveis = (0..<24).map { String(format: "%02d:00", $0) }

    // MARK: - FUNCTIONS
    func dateFormatted(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd, MMM yyyy"
        return formatter.string(from: date)
    }

    // MARK: - BODY
    var body: some View {
        ZStack {
            Color.customBackground.ignoresSafeArea()
            VStack(alignment: .center, spacing: 16) {
                
                VStack(spacing: 10) {
                    HStack {
                        Button {
                            withAnimation {
                                showingDatePicker.toggle()
                            }
                        } label: {
                            HStack {
                                Text(dateFormatted(date: selectedDate))
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(.white)
                                Image(systemName: showingDatePicker ? "chevron.up" : "chevron.down")
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    if showingDatePicker {
                        VStack(spacing: 16) {
                            DatePicker("", selection: $selectedDate, displayedComponents: .date)
                                .datePickerStyle(.graphical)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .foregroundStyle(.white)
                                )
                                .padding(.horizontal)
                                .onChange(of: selectedDate) { _ in
                                    withAnimation {
                                        tasks = (0..<24).map {
                                            Task(hourDayString: String(format: "%02d:00", $0))
                                        }
                                        showingDatePicker = false
                                    }
                                }
                            
                            Spacer()
                        }
                    }
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(.white)
                    
                }
                // Lista de tarefas
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(tasks.indices, id: \.self) { index in
                            HomeCellView(task: $tasks[index])
                                .frame(height: tasks[index].haveTaskBool ? 100 : 60)
                                .transition(.scale)
                        }
                    }
                    .padding()
                }
            }
        }
        // Sheet para o calendário (DatePicker)
//        .sheet(isPresented: $showingDatePicker) {
//            VStack(spacing: 16) {
//                Text("Selecionar Data")
//                    .font(.title2.bold())
//
//                DatePicker("", selection: $selectedDate, displayedComponents: .date)
//                    .datePickerStyle(.graphical)
//                    .padding()
//                    .background(Color(.systemGroupedBackground))
//                    .cornerRadius(12)
//                    .padding()
//
//                Button("Confirmar") {
//                    // (opcional) Reinicializa as tarefas com base na nova data
//                    tasks = (0..<24).map {
//                        Task(hourDayString: String(format: "%02d:00", $0))
//                    }
//                    showingDatePicker = false
//                }
//                .padding()
//                .frame(maxWidth: .infinity)
//                .background(Color.blue)
//                .foregroundColor(.white)
//                .cornerRadius(8)
//
//                Spacer()
//            }
//            .padding()
//        }

        // Sheet para criar tarefa
        .sheet(isPresented: $showingBottomSheet) {
            VStack(alignment: .leading, spacing: 15) {
                Text("Nova Tarefa")
                    .font(.title2.bold())

                // DatePicker para selecionar a data
                DatePicker("Data", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(.compact)

                CustomPicker(data: horasDisponiveis, placeholder: "Selecione a hora", lastSelectedIndex: $newTaskHour)
                    .foregroundStyle(.black)
                    .frame(height: 40)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.black, lineWidth: 1)
                            .frame(height: 40)
                    )

                
                CustomTextField(placeholder: "Nome da tarefas", padding: 12, text: $newTaskName, textColor: .black, textFieldColor: .black, frameWidth: .infinity, frameHeight: 40, cornerRadius: 8, lineWidth: 1, fontSize: 16, opacity: 1, backgroundColor: .clear, hasBorder: true, keyboardType: .default, lineColor: .black) {
                    //
                }
                
                CustomTextEditor(text: $newTaskDescription, placeholder: "Descrição")
                    .frame(height: 80)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.black, lineWidth: 1)
                            .frame(height: 80)
                    )
                
//                CustomTextField(placeholder: "Descrição", padding: 12, text: $newTaskDescription, textColor: .black, textFieldColor: .black, frameWidth: .infinity, frameHeight: 40, cornerRadius: 8, lineWidth: 1, fontSize: 16, opacity: 1, backgroundColor: .clear, hasBorder: true, keyboardType: .default, lineColor: .black) {
//                    //
//                }
                
                Button {
                    guard let selectedHour = newTaskHour else { return }

                    if let index = tasks.firstIndex(where: {
                        Int($0.hourDayString.prefix(2)) == selectedHour
                    }) {
                        let formatter = DateFormatter()
                        formatter.dateFormat = "MMMM dd" // ex: "May 20"
                        formatter.locale = Locale(identifier: "en_US") // Use "pt_BR" para português se quiser

                        let formattedDate = formatter.string(from: selectedDate)

                        tasks[index].haveTaskBool = true
                        tasks[index].weekDayString = formattedDate
                        tasks[index].taskHourString = newTaskName
                        tasks[index].descriptionTaskString = newTaskDescription
                    }

                    showingBottomSheet = false
                    newTaskHour = nil
                    newTaskName = ""
                    newTaskDescription = ""
                } label: {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundStyle(.customBlue)
                        .frame(height: 40)
                        .overlay {
                            Text("Adicionar Tarefa")
                                .foregroundStyle(.white)
                        }
                }
                Spacer()
            }
            .padding()
            .presentationDetents([.height(370)])
        }

        // Botão "+"
        .overlay(
            Button {
                showingBottomSheet = true
            } label: {
                Circle()
                    .fill(Color.white)
                    .frame(width: 50, height: 50)
                    .shadow(radius: 4)
                    .overlay(Image(systemName: "plus").foregroundColor(.blue))
                    .padding()
            },
            alignment: .bottomTrailing
        )
    }
}

#Preview {
    HomeView()
}

