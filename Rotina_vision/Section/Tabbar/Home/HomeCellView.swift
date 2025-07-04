//
//  HomeCellView.swift
//  Rotina_vision
//
//  Created by Mohamad on 18/05/25.
//

import SwiftUI

struct HomeCellView: View {
    //MARK: - PROPETRIES -
    
    @Binding var task: Task
    
    //MARK: - BODY -
    var body: some View {
        HStack {
            Text(task.hourDayString)
                .frame(width: 50)
            
            Rectangle()
                .frame(width: 3)
                .foregroundStyle(.customBlue)
            
            if task.haveTaskBool {
                NavigationLink {
                    TaskDetailView(task: $task)
                } label: {
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundStyle(.white)
                        .shadow(color: .black, radius: 15, x: 0, y: 10)
                        .overlay {
                            HStack(alignment: .top) {
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack {
                                        Image(systemName: "clock")
                                            .foregroundStyle(.customBlue)
                                        Text(task.hourDayString)
                                            .font(.caption)
                                    }
                                    
                                    Text(task.taskHourString)
                                        .font(.system(size: 16))
                                        .bold()
                                    
                                    Text(task.descriptionTaskString)
                                        .font(.system(size: 14))
                                        .multilineTextAlignment(.leading)
                                }
                                Spacer()
                                
                                Circle()
                                    .stroke(.customBlue, lineWidth: 1.5)
                                    .frame(width: 20)
                            }
                            .padding(.horizontal)
                        }
                }
            } else {
                Spacer()
            }
        }
    }
}

//struct HomeCellView_Preview : PreviewProvider {
//    static var previews: some View {
//        ZStack {
//            Color.customBackground.ignoresSafeArea()
//            HomeCellView(task: Task())
//                .frame(maxHeight: 100)
//                .padding()
//                .previewLayout(.sizeThatFits)
//        }
//    }
//}
