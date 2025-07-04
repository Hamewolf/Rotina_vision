//
//  Task.swift
//  Rotina_vision
//
//  Created by Mohamad on 18/05/25.
//

import SwiftUI

struct Task: Identifiable {
    let id = UUID()
    var hourDayString: String
    var haveTaskBool: Bool = false
    var weekDayString: String = ""
    var taskHourString: String = ""
    var descriptionTaskString: String = ""
}
