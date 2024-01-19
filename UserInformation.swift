//
//  UserInformation.swift
//  SSCProject
//
//  Created by Adit Chakraborty on 19/01/2024.
//

import Foundation

class UserInformation: ObservableObject {
    let tasks: [Event]
    
    init(tasks: [Event]) {
        self.tasks = tasks
    }
}
