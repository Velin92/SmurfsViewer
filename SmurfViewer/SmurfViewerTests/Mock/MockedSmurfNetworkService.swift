//
//  MockedSmurfNetworkService.swift
//  SmurfViewerTests
//
//  Created by Mauro Romito on 13/07/2020.
//  Copyright © 2020 Bofin Ltd. All rights reserved.
//

import Foundation
@testable import SmurfViewer
import XCTest
import Alamofire

class MockedSmurfNetworkService: SmurfsListService {
    
    enum TestType {
        case success
        case successButEmptyNames
        case failure
        case empty
    }
    
    var testType: TestType
    
    init(testType: TestType) {
        self.testType = testType
    }
    
    func getSmurfsListcompletion(completion: @escaping (AFResult<SmurfsListResponse>) -> Void) {
        switch testType {
        case .failure:
            completion(.failure(AFError.sessionInvalidated(error: nil)))
        case .successButEmptyNames:
            completion (.success([Smurf(name: "", path: "a", wikipediaInfo: "a"), Smurf(name: nil, path: "B", wikipediaInfo: "B")]))
        case .empty:
            completion (.success([]))
        case .success:
            completion (.success([Smurf(name: "A", path: "a", wikipediaInfo: "a"), Smurf(name: "B", path: "B", wikipediaInfo: "B"), Smurf(name: nil, path: "C", wikipediaInfo: "")]))
            //should return only 2 smurfs
        }
    }
    
    func getSmurfImage(for path: String, completion: @escaping (AFDataResponse<Data>) -> Void) {
        completion(AFDataResponse<Data>(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: .success(Data())))
    }
}
