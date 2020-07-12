//
//  SmurfNetworkService.swift
//  SmurfViewer
//
//  Created by Mauro Romito on 12/07/2020.
//  Copyright © 2020 Bofin Ltd. All rights reserved.
//

import Foundation
import Alamofire

protocol SmurfsListService {
    func getSmurfsListcompletion(completion: @escaping (AFResult<SmurfsListResponse>) -> Void)
}

protocol SmurfImageService {
    func getSmurfImage(for path: String, completion: @escaping (AFDataResponse<Data>) -> Void)
}

class SmurfNetworkService {
    private func request<T: Codable> (_ urlConvertible: URLRequestConvertible, completion: @escaping (AFResult<T>) -> Void) {
        AF.request(urlConvertible).responseData(completionHandler:{ [weak self] (dataResponse: AFDataResponse<Data>) in
            self?.printResponse(response: dataResponse)
            let decoder = JSONDecoder()
            let response: AFResult<T> = decoder.decodeResponse(from: dataResponse)
            completion(response)
        })
    }
    
    private func printResponse(response: AFDataResponse<Data>) {
        guard let value = response.value,
            let string = NSString(data: value, encoding: String.Encoding.utf8.rawValue)
            else { return }
        
        print("response is:\n \(string)")
    }
}

extension SmurfNetworkService: SmurfsListService {
    func getSmurfsListcompletion(completion: @escaping (AFResult<SmurfsListResponse>) -> Void) {
        request(APIRouter.getSmurfsList, completion: completion)
    }
}

extension SmurfNetworkService: SmurfImageService {
    func getSmurfImage(for path: String, completion: @escaping (AFDataResponse<Data>) -> Void) {
        AF.request(APIRouter.getSmurfImage(path: path)).responseData(completionHandler: completion)
    }
}
