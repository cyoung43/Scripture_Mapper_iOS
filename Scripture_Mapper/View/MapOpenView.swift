//
//  MapOpenView.swift
//  Scripture_Mapper
//
//  Created by Chris Young on 11/25/21.
//

import SwiftUI

struct MapOpenView: View {
    var bookName: String
    var chapter: Int
    var onDismiss: () -> ()
    
    var body: some View {
        NavigationView {
            MapView()
                .navigationBarTitle("\(bookName) \(chapter)")
                .navigationBarItems(leading: Button(action: {
                    onDismiss()
                }, label: {
                    Text("Close")
                }))
        }
    }
}
