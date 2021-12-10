//
//  MapView.swift
//  Scripture_Mapper
//
//  Created by Chris Young on 11/24/21.
//

import SwiftUI
import MapKit

struct MapView: View {
    @EnvironmentObject var scriptureMapper: ScriptureMapper
    
    var body: some View {
        Map(coordinateRegion: $scriptureMapper.region, annotationItems: scriptureMapper.geoPlaces) { geoPlace in
            MapAnnotation(coordinate: geoPlace.coordinate, anchorPoint: CGPoint(x: 0.5, y: 1)) {
                VStack {
                    Image(systemName: "mappin.circle.fill")
                        .foregroundColor(.black)
                    Text("\(geoPlace.placename)")
                        .background(.white)
                }
                .onTapGesture {
                    scriptureMapper.setCurrentGeoPlace(placeId: geoPlace.id)
                    withAnimation {
                        scriptureMapper.setRegion(gPlaces: scriptureMapper.currentGeoPlaces)
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
