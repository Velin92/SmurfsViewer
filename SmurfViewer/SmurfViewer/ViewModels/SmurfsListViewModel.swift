//
//  SmurfsListViewModel.swift
//  SmurfViewer
//
//  Created by Mauro Romito on 12/07/2020.
//  Copyright © 2020 Bofin Ltd. All rights reserved.
//

import Foundation

class SmurfsListViewModel: ObservableObject {
    
    enum ExceptionState {
        case empty
        case error
        case none
    }
    
    @Published var cellViewModels: [SmurfCellViewModel] = []
    @Published var exceptionState = ExceptionState.none
    @Published var isLoading: Bool = true
    
    
    var exceptionMessage: String {
        switch exceptionState {
        case .empty:
            return "There are no Smurfs here.\nGargamel maybe ate them all!"
        case .error:
            return "Ops! Something went wrong!\nI bet it's Gargamel's fault"
        default:
            return ""
        }
    }
    
    let networkService = SmurfNetworkService()
    
    func fetchSmurfData() {
        isLoading = true
        networkService.getSmurfsListcompletion {[weak self] result in
            switch result {
            case .success(let response):
                let validModels = response.filter({$0.name != nil})
                if !validModels.isEmpty {
                    self?.exceptionState = .none
                    self?.fetchImages(for: validModels) { [weak self] imageDatas in
                        precondition(imageDatas.count == validModels.count, "Something is wrong, the image datas and the viewModels do not match")
                        for i in 0..<validModels.count {
                            if let cellModel = SmurfCellViewModel(from: validModels[i], with: imageDatas[i]) {
                                self?.cellViewModels.append(cellModel)
                            }
                        }
                        self?.isLoading = false
                    }
                } else {
                    self?.isLoading = false
                    self?.exceptionState = .empty
                }
            case .failure (let error):
                print(error)
                self?.isLoading = false
                self?.exceptionState = .error
            }
        }
    }
    
    func fetchImages(for models: [Smurf], completion: @escaping ([Data?])->Void) {
        let queue = DispatchQueue.init(label: "ImagesQueue", qos: .background, attributes: .concurrent)
        let serviceGroup = DispatchGroup()
        var result: [Data?] = [Data?].init(repeating: nil, count: models.count)
        for (index, model) in models.enumerated() {
            serviceGroup.enter()
            queue.async { [weak self] in
                if let path = model.path {
                    self?.networkService.getSmurfImage(for: path) { dataResponse in
                        if dataResponse.error == nil && dataResponse.data != nil {
                            //because even if structs are thread safe in Swift, operations on elements of a collection are not
                            //and require to be accessed by only one thread at time
                            queue.async(group: serviceGroup, flags: .barrier) {
                                result[index] = dataResponse.data
                            }
                        }
                        serviceGroup.leave()
                    }
                } else {
                    serviceGroup.leave()
                }
            }
        }
        serviceGroup.notify(queue: DispatchQueue.main) {
            completion(result)
        }
    }
    
    deinit {
        print("*SmurfsListViewModel deinit called*")
    }
}
