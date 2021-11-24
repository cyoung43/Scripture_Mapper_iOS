//
//  MapView.swift
//  Scripture_Mapper
//
//  Created by Chris Young on 11/24/21.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 31.778389, longitude: 35.234736), span: MKCoordinateSpan(latitudeDelta: 3, longitudeDelta: 3))
    
    var body: some View {
        Map(coordinateRegion: $region)
            .edgesIgnoringSafeArea(.all)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
