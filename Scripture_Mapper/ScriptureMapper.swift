//
//  ScriptureMapper.swift
//  Scripture_Mapper
//
//  Created by Chris Young on 11/25/21.
//

import Foundation
import MapKit

// TO DO:
//      1. Not quite the right formula for updating the region with each new set of geoPlaces
//      2. Can still see the popup modal sheet when user click on geoLocation on the iPad
//      3. How to reset the screen with my update button
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
            
            if place.placename == "Egypt" {
                print(place)
            }
        }
        
        geoPlaces = newPlaces
    }
    
    func setCurrentGeoPlace(placeId: Int) {
        currentGeoPlaces = []
        
        if let place = GeoDatabase.shared.geoPlaceForId(placeId) {
            currentGeoPlaces.append(place)
        }
    }
    
    // TO DO: work on getting this to work right
    func setRegion(gPlaces: [GeoPlace]) {
        let maxLng = (gPlaces.max { $0.longitude < $1.longitude })?.longitude ?? 0
        let maxLat = (gPlaces.max { $0.latitude < $1.latitude })?.latitude ?? 0
        let minLng = (gPlaces.min { $0.longitude < $1.longitude })?.longitude ?? 0
        let minLat = (gPlaces.min { $0.latitude < $1.latitude })?.latitude ?? 0
        
        print(minLat, maxLat)
        print(minLng, maxLng)
        
        let centerLong = (maxLng - minLng) / 2 + minLng
        let centerLat = (maxLat - minLat) / 2 + minLat
        let margin = 1.1
        
        var spanLong: Double {
            if gPlaces.count < 2 {
                return 0.2
            }
            else {
                return abs(maxLng - minLng) * margin
            }
        }
        
        var spanLat: Double {
            if gPlaces.count < 2 {
                return 0.2
            }
            else {
                return abs(maxLat - minLat) * margin
            }
        }
        
        print(centerLat, centerLong)
        
        region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: centerLat, longitude: centerLong), span: MKCoordinateSpan(latitudeDelta: spanLat, longitudeDelta: spanLong))
        
        print(region)
    }
    
}
