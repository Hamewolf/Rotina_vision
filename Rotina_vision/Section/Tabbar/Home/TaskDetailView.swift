//
//  TaskDetailView.swift
//  Rotina_vision
//
//  Created by Mohamad on 20/05/25.
//

import SwiftUI

struct TaskDetailView: View {
    // MARK: - PROPERTIES
    
    @Binding var task: Task
    @State private var isEditTask: Bool = false
    @State private var titleString: String = ""
    @State private var descriptionString: String = ""
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            Color.customBackWhite.ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Text(task.weekDayString)
                        
                        Circle()
                            .frame(width: 10)
                        
                        Text(task.hourDayString)
                    }
                    .font(.title)
                    
                    TextField("", text: $titleString)
                        .font(.largeTitle)
                        .bold()
                        .disabled(!isEditTask)
                    
                    // Substituindo TextEditor por um TextField modificado que cresce com o conteúdo
                    ZStack(alignment: .topLeading) {
                        if descriptionString.isEmpty {
                            Text("Descrição")
                                .foregroundColor(.gray.opacity(0.5))
                                .padding(.top, 8)
                                .padding(.leading, 4)
                        }
                        
                        TextEditor(text: $descriptionString)
                            .font(.subheadline)
                            .scrollContentBackground(.hidden) // Remove o fundo do TextEditor
                            .background(Color.clear) // Fundo transparente
                            .frame(minHeight: 100) // Altura mínima
                            .disabled(!isEditTask)
                    }
                    
                    Spacer(minLength: 20)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundStyle(.customBackground)
                        .shadow(color: .white, radius: 12, x: 0, y: 10)
                )
                .padding()
            }
        }
        .onAppear {
            titleString = task.taskHourString
            descriptionString = task.descriptionTaskString
        }
        .navigationTitle("Detalhe da Tarefa")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isEditTask.toggle()
                } label: {
                    Image(systemName: isEditTask ? "checkmark.circle.fill" : "slider.horizontal.3")
                        .foregroundStyle(isEditTask ? .green : .blue)
                }
            }
        }
    }
}

#Preview {
    NavigationView {
        TaskDetailView(task: .constant(Task(hourDayString: "12:00", haveTaskBool: true, weekDayString: "May 20", taskHourString: "teste", descriptionTaskString: "Lorem ipsum dolor sit amet. Id consectetur delectus et odio totam est quisquam tempora est debitis explicabo ex voluptas omnis. Aut commodi dolor id quaerat quod ut placeat voluptas est animi voluptate? Et suscipit consequatur qui voluptas libero et magnam doloremque hic expedita neque ad dolorem dolores est aliquid iure qui veritatis quas. Sit ipsum nulla non ipsa voluptates sit dignissimos quia ut velit fugiat est voluptas sunt et dolorem omnis eum alias nostrum. Non vitae accusamus et facere nihil ut sapiente corporis et sapiente ducimus. Non atque nihil At nesciunt commodi non velit molestias sed deserunt voluptatum non autem asperiores 33 voluptas aliquid eum ipsum perferendis. Cum mollitia Quis id vitae ducimus rem maiores nostrum et doloremque tempore sed sapiente nihil ad rerum adipisci! Lorem ipsum dolor sit amet. Id consectetur delectus et odio totam est quisquam tempora est debitis explicabo ex voluptas omnis. Aut commodi dolor id quaerat quod ut placeat voluptas est animi voluptate? Et suscipit consequatur qui voluptas libero et magnam doloremque hic expedita neque ad dolorem dolores est aliquid iure qui veritatis quas. Sit ipsum nulla non ipsa voluptates sit dignissimos quia ut velit fugiat est voluptas sunt et dolorem omnis eum alias nostrum. Non vitae accusamus et facere nihil ut sapiente corporis et sapiente ducimus. Non atque nihil At nesciunt commodi non velit molestias sed deserunt voluptatum non autem asperiores 33 voluptas aliquid eum ipsum perferendis. Cum mollitia Quis id vitae ducimus rem maiores nostrum et doloremque tempore sed sapiente nihil ad rerum adipisci!")))
    }
}
