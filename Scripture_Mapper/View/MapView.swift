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
    @State var region: MKCoordinateRegion
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: scriptureMapper.geoPlaces) { geoPlace in
            MapAnnotation(coordinate: geoPlace.coordinate, anchorPoint: CGPoint(x: 0.5, y: 1)) {
                Image(systemName: "mappin.circle.fill")
                    .foregroundColor(.black)
                    //.foregroundColor(Color(red: 0.7, green: 0.1, blue: 0.1))
                    //.shadow(radius: 2, x: 1, y: 1)
                Text("\(geoPlace.placename)")
                    .background(.white)
            }
        }
    }
}

//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView()
//    }
//}
