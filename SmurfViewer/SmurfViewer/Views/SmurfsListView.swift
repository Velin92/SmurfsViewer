//
//  SmurfsView.swift
//  SmurfViewer
//
//  Created by Mauro Romito on 12/07/2020.
//  Copyright © 2020 Bofin Ltd. All rights reserved.
//

import SwiftUI

struct SmurfsListView: View {
    
    @ObservedObject var viewModel = SmurfsListViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.cellViewModels, content: {
                cellModel in
                SmurfCellView(viewModel: cellModel)
            })
        }
        .navigationBarTitle("Smurfs")
        .onAppear {
            self.viewModel.fetchSmurfData()
        }
    }
}

struct SmurfsListView_Previews: PreviewProvider {
    static var previews: some View {
        SmurfsListView()
    }
}
