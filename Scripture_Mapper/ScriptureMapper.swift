//
//  ScriptureMapper.swift
//  Scripture_Mapper
//
//  Created by Chris Young on 11/25/21.
//

import Foundation

class ScriptureMapper: ObservableObject, GeoPlaceCollector {
    var geoPlaces = [GeoPlace]()
    
    init() {
        ScriptureRenderer.shared.injectGeoPlaceCollector(self)
    }
    
    func setGeocodedPlaces(_ places: [GeoPlace]?) {
        if let places = places {
            geoPlaces = places
            
            geoPlaces.forEach { place in
                print(place.placename)
            }
        }
    }
    
    
}
