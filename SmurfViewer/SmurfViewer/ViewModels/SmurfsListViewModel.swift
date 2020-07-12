//
//  SmurfsListViewModel.swift
//  SmurfViewer
//
//  Created by Mauro Romito on 12/07/2020.
//  Copyright © 2020 Bofin Ltd. All rights reserved.
//

import Foundation

class SmurfsListViewModel: ObservableObject {
    
    enum ViewState {
        case empty
        case error
        case loaded
        case loading
    }
    
    @Published var cellViewModels: [SmurfCellViewModel] = []
    @Published var exception = ViewState.loading
    
}
