//
//  Scripture_Mapper.swift
//  Scripture_Mapper
//
//  Created by Chris Young on 11/22/21.
//

import SwiftUI
import MapKit

struct ScripturesMappedView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 31.778389, longitude: 35.234736), span: MKCoordinateSpan(latitudeDelta: 3, longitudeDelta: 3))
    
    var body: some View {
        NavigationView {
            VolumesView()
            PrimaryMapView()
            // MapView here if iPad. If phone, use a modal sheet for the mapping maybe?
            // When doing the iPad and clicking on the chapters of Joshua, it shows all the pins in the chapter....
            // TO DO: .edgesIgnoringSafeArea
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ScripturesMappedView()
    }
}
