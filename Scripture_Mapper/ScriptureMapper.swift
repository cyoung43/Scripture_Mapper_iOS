//
//  ScriptureMapper.swift
//  Scripture_Mapper
//
//  Created by Chris Young on 11/25/21.
//

import Foundation
import MapKit

// TO DO:
//      1. Convert chapter list to nicely formatted buttons then I will be done
//      2. Check the zoom in option for the single place name on the iphone... it's not zooming anymore

class ScriptureMapper: ObservableObject, GeoPlaceCollector {
    @Published var geoPlaces = [GeoPlace]()
    @Published var isDetailViewVisible = false
    @Published var currentGeoPlaces = [GeoPlace]()
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 31.778389, longitude: 35.234736), span: MKCoordinateSpan(latitudeDelta: 3, longitudeDelta: 3))
    
    var book: String = ""
    var chapterNum: String = ""
    
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
            currentGeoPlaces.append(place)
        }
    }
    
    // TO DO: work on getting this to work right
    func setRegion(gPlaces: [GeoPlace]) {
        
        if gPlaces.count == 0 {
            region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 31.778389, longitude: 35.234736), span: MKCoordinateSpan(latitudeDelta: 3, longitudeDelta: 3))
            
            return
        }
        
        let maxLng = (gPlaces.max { $0.longitude < $1.longitude })?.longitude ?? 0
        let maxLat = (gPlaces.max { $0.latitude < $1.latitude })?.latitude ?? 0
        let minLng = (gPlaces.min { $0.longitude < $1.longitude })?.longitude ?? 0
        let minLat = (gPlaces.min { $0.latitude < $1.latitude })?.latitude ?? 0
        
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
        
        region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: centerLat, longitude: centerLong), span: MKCoordinateSpan(latitudeDelta: spanLat, longitudeDelta: spanLong))
    }
    
    func getNavTitle() -> String {
        return "\(book) \(chapterNum)"
    }
    
    func setNavTitle(_ bookName: String, _ chapter: String = "") {
        book = bookName
        chapterNum = chapter
    }
    
}
