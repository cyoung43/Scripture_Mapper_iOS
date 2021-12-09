//
//  Scripture_Mapper.swift
//  Scripture_Mapper
//
//  Created by Chris Young on 11/22/21.
//

import SwiftUI
import MapKit

struct ScripturesMappedView: View {
    
    var body: some View {
        NavigationView {
            VolumesView()
            PrimaryMapView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ScripturesMappedView()
    }
}
