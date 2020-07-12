//
//  SmurfsView.swift
//  SmurfViewer
//
//  Created by Mauro Romito on 12/07/2020.
//  Copyright © 2020 Bofin Ltd. All rights reserved.
//

import SwiftUI

struct SmurfsView: View {
    var body: some View {
        List {
                SmurfCellView()
        }
        .navigationBarTitle("Smurfs")
    }
}

struct SmurfsView_Previews: PreviewProvider {
    static var previews: some View {
        SmurfsView()
    }
}
