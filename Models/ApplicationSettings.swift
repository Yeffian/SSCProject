//
//  CareeInformation.swift
//  SSCProject
//
//  Created by Adit Chakraborty on 04/02/2024.
//

import Foundation

class ApplicationSettings : ObservableObject {
    @Published var careeName: String?
    
    init(careeName: String? = nil) {
        self.careeName = careeName
    }
}
