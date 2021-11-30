//
//  ScriptureMapper.swift
//  Scripture_Mapper
//
//  Created by Chris Young on 11/25/21.
//

import Foundation

class ScriptureMapper: ObservableObject, GeoPlaceCollector {
    @Published var geoPlaces = [GeoPlace]()
    
    init() {
        ScriptureRenderer.shared.injectGeoPlaceCollector(self)
    }
    
    func setGeocodedPlaces(_ places: [GeoPlace]?) {
        // TO DO: only copy over the unique geoPlaces
        // even if the coordinates are the same, we want to combine the pin and have a comma for the other place name
        if let places = places {
            geoPlaces = places
            
            geoPlaces.forEach { place in
                print(place.placename)
            }
        }
    }
}
