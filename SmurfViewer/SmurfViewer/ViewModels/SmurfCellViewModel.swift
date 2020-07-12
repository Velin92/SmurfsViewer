//
//  SmurfCellViewModel.swift
//  SmurfViewer
//
//  Created by Mauro Romito on 12/07/2020.
//  Copyright © 2020 Bofin Ltd. All rights reserved.
//

import Foundation

class SmurfCellViewModel: Identifiable {
    
    let name: String
    let description: String?
    
    init?(from model: Smurf) {
        //the name is required to be displayed in the list
        guard let name = model.name else{ return nil}
        self.name = name
        self.description = model.wikipediaInfo
    }
}
