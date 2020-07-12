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
    @Published var state = ViewState.loading
    
    let networkService : SmurfsListService = SmurfNetworkService()
    
    func fetchSmurfData() {
        state = .loading
        networkService.getSmurfsListcompletion {[weak self] result in
            switch result {
            case .success(let response):
                self?.cellViewModels = response.compactMap(SmurfCellViewModel.init)
                if let viewModels = self?.cellViewModels, !viewModels.isEmpty {
                    self?.state = .loaded
                } else {
                    self?.state = .empty
                }
                break
            case .failure (let error):
                print(error)
                self?.state = .error
                break
            }
        }
    }
    
}
