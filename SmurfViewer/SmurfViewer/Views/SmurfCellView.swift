//
//  SmurfCellView.swift
//  SmurfViewer
//
//  Created by Mauro Romito on 12/07/2020.
//  Copyright © 2020 Bofin Ltd. All rights reserved.
//

import SwiftUI

struct SmurfCellView: View {
    
    
    
    var body: some View {
        VStack {
            Text("Smurf Name")
            Image("VanitySmurf").resizable()
                .frame(width: 200.0, height: 200.0)
                .background(Color.clear)
            HStack {
                VStack (alignment: .leading){
                    Text("Description:")
                        .multilineTextAlignment(.leading)
                    Text("Description Infos")
                        .multilineTextAlignment(.leading)
                        .padding([.top, .trailing])
                }
                Spacer()
            }.padding()
        }
    }
}

struct SmurfCellView_Previews: PreviewProvider {
    static var previews: some View {
        SmurfCellView()
    }
}
