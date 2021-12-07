//
//  ScriptureMapper.swift
//  Scripture_Mapper
//
//  Created by Chris Young on 11/25/21.
//

import Foundation
import MapKit

class ScriptureMapper: ObservableObject, GeoPlaceCollector {
    @Published var geoPlaces = [GeoPlace]()
    @Published var isDetailViewVisible = false
    @Published var currentGeoPlaces = [GeoPlace]()
    @Published var region = MKCoordinateRegion()
    
    init() {
        ScriptureRenderer.shared.injectGeoPlaceCollector(self)
    }
    
    func setGeocodedPlaces(_ places: [GeoPlace]?) {
        // TO DO: only copy over the unique geoPlaces
        // even if the coordinates are the same, we want to combine the pin and have a comma for the other place name
        var newPlaces = [GeoPlace]()
        
        if let places = places {
            geoPlaces = places
            
            // TO DO: hitting an infinite loop here... not good
//            geoPlaces.forEach { place in
//                if newPlaces.count > 0 {
//
//                    for i in newPlaces.indices {
//                        if checkDelta(p1: place, p2: newPlaces[i]) {
//                            if !newPlaces[i].placename.contains(place.placename) {
//                                newPlaces[i].placename.append(", \(place.placename)")
//                            }
//                        }
//                        else {
//                            newPlaces.append(place)
//                        }
//                    }
//                }
//                else {
//                    newPlaces.append(place)
//                }
//            }
        }
//
//        geoPlaces = newPlaces
        
        geoPlaces.forEach { place in
            print(place.placename)
        }
    }
    
    func setCurrentGeoPlace(placeId: Int) {
        if let place = GeoDatabase.shared.geoPlaceForId(placeId) {
            print(place)
            currentGeoPlaces.append(place)
        }
    }
    
    // TO DO: work on getting this to work right
    func setRegion() {
        let maxLng = geoPlaces.max { $0.longitude > $1.longitude }
        let maxLat = geoPlaces.max { $0.latitude > $1.latitude }
        let minLng = geoPlaces.min { $0.longitude < $1.longitude }
        let minLat = geoPlaces.min { $0.latitude < $1.latitude }
        print(maxLng)
        print(type(of: maxLng))
        // region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: ((maxLat + minLat) / 2), longitude: ((maxLng + minLng) / 2)), span: MKCoordinateSpan(latitudeDelta: 3, longitudeDelta: 3))
    }
    
    
    private func checkDelta(p1: GeoPlace, p2: GeoPlace) -> Bool {
        let delta = 0.0000001
        
        return abs(p1.latitude - p2.latitude) < delta && abs(p1.longitude - p2.longitude) < delta
    }
}
