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
    @Published var region = MKCoordinateRegion()
    
    init() { }
    
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
        if let place = GeoDatabase.shared.geoPlaceForId(placeId) {
            print(place)
            currentGeoPlaces.append(place)
        }
    }
    
    // TO DO: work on getting this to work right
    func setRegion() {
        let maxLng = (geoPlaces.max { $0.longitude > $1.longitude })?.longitude ?? 0 // defaulting here
        let maxLat = geoPlaces.max { $0.latitude > $1.latitude }
        let minLng = geoPlaces.min { $0.longitude < $1.longitude }
        let minLat = geoPlaces.min { $0.latitude < $1.latitude }
//        print(maxLng)
//        print(type(of: maxLng))
        // region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: ((maxLat + minLat) / 2), longitude: ((maxLng + minLng) / 2)), span: MKCoordinateSpan(latitudeDelta: 3, longitudeDelta: 3))
    }
    
    
    private func checkDelta(p1: GeoPlace, p2: GeoPlace) -> Bool {
        let delta = 0.0000001
        
        return abs(p1.latitude - p2.latitude) < delta && abs(p1.longitude - p2.longitude) < delta
    }
    
//    private func createUnique(place: GeoPlace) {
//        if newPlaces.count > 0 {
//            for i in newPlaces.indices {
//                if checkDelta(p1: place, p2: newPlaces[i]) {
//                    if !newPlaces[i].placename.contains(place.placename) {
//                        newPlaces[i].placename.append(", \(place.placename)")
//                    }
//                }
//                else {
//                    newPlaces.append(place)
//                }
//            }
//        }
//        else {
//            newPlaces.append(place)
//        }
//    }
}
