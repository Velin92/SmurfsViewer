//
//  UIImage+optionalInitFromOptionalData.swift
//  SmurfViewer
//
//  Created by Mauro Romito on 13/07/2020.
//  Copyright © 2020 Bofin Ltd. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    convenience init? (data: Data?) {
        guard let data = data else {
            return nil
        }
        self.init(data: data)
    }
}
