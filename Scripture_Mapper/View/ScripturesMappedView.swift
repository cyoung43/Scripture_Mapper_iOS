//
//  Scripture_Mapper.swift
//  Scripture_Mapper
//
//  Created by Chris Young on 11/22/21.
//

import SwiftUI
import MapKit

struct ScripturesMappedView: View {
    @EnvironmentObject var scriptureMapper: ScriptureMapper
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 31.778389, longitude: 35.234736), span: MKCoordinateSpan(latitudeDelta: 3, longitudeDelta: 3))
    
    var body: some View {
        NavigationView {
            VolumesView()
            Map(coordinateRegion: $region, annotationItems: scriptureMapper.geoPlaces) { geoPlace in
                MapAnnotation(coordinate: geoPlace.coordinate, anchorPoint: CGPoint(x: 0.5, y: 0)) {
                    Image(systemName: "mappin")
                        .foregroundColor(Color(red: 0.7, green: 0.1, blue: 0.1))
                        .shadow(radius: 2, x: 1, y: 1)
                }
            } // here if iPad. If phone, use a modal sheet for the mapping maybe?
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ScripturesMappedView()
    }
}
