//
//  SmurfModel.swift
//  SmurfViewer
//
//  Created by Mauro Romito on 12/07/2020.
//  Copyright © 2020 Bofin Ltd. All rights reserved.
//

import Foundation

struct Smurf: Codable {
    let name, path, wikipediaInfo: String?
}

typealias SmurfsListResponse = [Smurf]
