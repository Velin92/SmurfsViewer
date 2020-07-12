//
//  JSONDecoder+decodeResponse.swift
//  SmurfViewer
//
//  Created by Mauro Romito on 13/07/2020.
//  Copyright © 2020 Bofin Ltd. All rights reserved.
//

import Foundation

import Foundation
import Alamofire

extension JSONDecoder {
    
  func decodeResponse<T: Decodable>(from response: AFDataResponse<Data>) -> AFResult<T> {
    guard response.error == nil else {
      print(response.error!)
      return .failure(response.error!)
    }

    guard let responseData = response.data else {
        print("didn't get any data from API")
        return .failure(AFError.responseValidationFailed(reason: .dataFileNil))
    }

    do {
      let item = try decode(T.self, from: responseData)
      return .success(item)
    } catch {
        print("error trying to decode response")
        print(error)
        return AFResult.failure(AFError.responseSerializationFailed(reason: .decodingFailed(error: error)))
    }
  }
}
