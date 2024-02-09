//
//  CareeInformation.swift
//  SSCProject
//
//  Created by Adit Chakraborty on 04/02/2024.
//

import Foundation

class ApplicationSettings : ObservableObject {
    @Published var careeName: String?
    @Published var useIcons: Bool?
    
    init(careeName: String? = nil, useIcons: Bool? = false) {
        self.careeName = careeName
        self.useIcons = useIcons
    }
}
