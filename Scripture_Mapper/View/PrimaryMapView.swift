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
            MapView(region: scriptureMapper.region)
                .onAppear {
                    scriptureMapper.isDetailViewVisible = geometry.frame(in: .global).maxY > 0
                    scriptureMapper.setRegion(gPlaces: scriptureMapper.geoPlaces)
                }
        }
    }
}

struct PrimaryMapView_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryMapView()
    }
}
