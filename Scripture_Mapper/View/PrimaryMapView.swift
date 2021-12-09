//
//  PrimaryMapView.swift
//  Scripture_Mapper
//
//  Created by Chris Young on 12/1/21.
//

import SwiftUI

struct PrimaryMapView: View {
    @EnvironmentObject var scriptureMapper: ScriptureMapper
    
    var body: some View {
        GeometryReader { geometry in
            MapOpenView(bookName: scriptureMapper.book, chapter: Int(scriptureMapper.chapterNum) ?? 0, onDismiss: {})
                .onAppear {
                    scriptureMapper.isDetailViewVisible = geometry.frame(in: .global).maxY > 0
                    withAnimation {
                        scriptureMapper.setRegion(gPlaces: scriptureMapper.geoPlaces)
                    }
                }
                .edgesIgnoringSafeArea(.horizontal)
                .edgesIgnoringSafeArea(.bottom)
               
        }
    }
}

struct PrimaryMapView_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryMapView()
    }
}
