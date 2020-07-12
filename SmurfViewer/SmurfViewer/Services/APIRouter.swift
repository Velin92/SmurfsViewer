//
//  APIRouter.swift
//  SmurfViewer
//
//  Created by Mauro Romito on 12/07/2020.
//  Copyright © 2020 Bofin Ltd. All rights reserved.
//

import Foundation
import Alamofire


enum APIRouter: URLRequestConvertible {
    
    static let baseURLPath = "https://raw.githubusercontent.com/Bofin/iOSTechTestData/master"
    
    enum HTTPHeaderField: String {
        case authentication = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
    }
    
    enum ContentType: String {
        case json = "application/json"
        case image = "image/png"
    }
    
    case getSmurfsList
    case getSmurfImage(path: String)
    
    var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    var path: String {
        
        switch self {
        case .getSmurfsList:
            return "/SmurfPayload.json"
        case .getSmurfImage(let path):
            return "/\(path)"
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        let url = try APIRouter.baseURLPath.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        switch self {
        case .getSmurfImage:
            urlRequest.setValue(ContentType.image.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        case .getSmurfsList:
            urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        }
        
        print("GET request url\n: \(String(describing: urlRequest.url?.absoluteString))")
        return urlRequest
    }
}
