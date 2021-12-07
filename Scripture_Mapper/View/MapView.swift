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
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 31.778389, longitude: 35.234736), span: MKCoordinateSpan(latitudeDelta: 3, longitudeDelta: 3))
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: scriptureMapper.geoPlaces) { geoPlace in
            MapAnnotation(coordinate: geoPlace.coordinate, anchorPoint: CGPoint(x: 0.5, y: 1)) {
                Image(systemName: "mappin")
                    .foregroundColor(Color(red: 0.7, green: 0.1, blue: 0.1))
                    .shadow(radius: 2, x: 1, y: 1)
                Text("\(geoPlace.placename)")
            }
        }
        
        // Need to only ignore on the ipad, not the iphone
    }
}

//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView()
//    }
//}
