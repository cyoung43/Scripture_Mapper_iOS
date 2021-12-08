//
//  ScriptureMapper.swift
//  Scripture_Mapper
//
//  Created by Chris Young on 11/25/21.
//

import Foundation
import MapKit

// watch viewAltitude to see if we can set the height of the map
// turn viewAltitude into a latitude and longitude delta
class ScriptureMapper: ObservableObject, GeoPlaceCollector {
    @Published var geoPlaces = [GeoPlace]()
    @Published var isDetailViewVisible = false
    @Published var currentGeoPlaces = [GeoPlace]()
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 31.778389, longitude: 35.234736), span: MKCoordinateSpan(latitudeDelta: 3, longitudeDelta: 3))
    
    init() { }
    
    // MARK: - Helpers
    
    func setGeocodedPlaces(_ places: [GeoPlace]?) {
        var newPlaces = [GeoPlace]()
        let delta = 0.0000001
        
        if let places = places {
            geoPlaces = places
        }
        
        geoPlaces.forEach { place in
            
            if let index = newPlaces.firstIndex(where: { abs($0.latitude - place.latitude) < delta && abs($0.longitude - place.longitude) < delta }) {
                if !newPlaces[index].placename.contains(place.placename) {
                    newPlaces[index].placename.append(", \(place.placename)")
                }
            }
            else {
                newPlaces.append(place)
            }
        }
        
        geoPlaces = newPlaces
    }
    
    func setCurrentGeoPlace(placeId: Int) {
        currentGeoPlaces = []
        if let place = GeoDatabase.shared.geoPlaceForId(placeId) {
            print(place.placename)
            currentGeoPlaces.append(place)
        }
    }
    
    // TO DO: work on getting this to work right
    func setRegion(gPlaces: [GeoPlace]) {
        let maxLng = (gPlaces.max { $0.longitude < $1.longitude })?.longitude ?? 0
        let maxLat = (gPlaces.max { $0.latitude < $1.latitude })?.latitude ?? 0
        let minLng = (gPlaces.min { $0.longitude < $1.longitude })?.longitude ?? 0
        let minLat = (gPlaces.min { $0.latitude < $1.latitude })?.latitude ?? 0
        
        var longDelta: Double {
            if gPlaces.count == 1 {
                return (gPlaces[0].viewAltitude ?? 5000) / 50000
            }
            else {
                return (gPlaces[0].viewAltitude ?? 5000) / 1650
            }
        }
        
        print(longDelta)
        
        region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: ((maxLat + minLat) / 2), longitude: ((maxLng + minLng) / 2)), span: MKCoordinateSpan(latitudeDelta: longDelta, longitudeDelta: longDelta))
        
        print(region)
    }
    
}
