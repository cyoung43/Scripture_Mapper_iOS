//
//  MapOpenView.swift
//  Scripture_Mapper
//
//  Created by Chris Young on 11/25/21.
//

import SwiftUI

struct MapOpenView: View {
    @EnvironmentObject var scriptureMapper: ScriptureMapper
    
    var bookName: String
    var chapter: Int
    var onDismiss: () -> ()
    
    var body: some View {
        //NavigationView {
            MapView()
                .navigationBarTitle("\(bookName) \(chapter == 0 ? "" : "\(chapter)")")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading:
                    Group {
                        if !scriptureMapper.isDetailViewVisible {
                            Button(action: {
                                onDismiss()
                            }, label: {
                                Text("Close")
                        })}}, trailing: Button(action: {
                    withAnimation {
                        scriptureMapper.setRegion(gPlaces: scriptureMapper.geoPlaces)
                    }
                }, label: {
                    Image(systemName: "map")
                }))
        //}
    }
}
