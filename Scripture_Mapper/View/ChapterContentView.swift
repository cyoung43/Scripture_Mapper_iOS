//
//  ChapterContentView.swift
//  Scripture_Mapper
//
//  Created by Chris Young on 11/22/21.
//

import SwiftUI

struct ChapterContentView: View {
    var book: Book
    var chapter: Int
    private var html: String {
        ScriptureRenderer.shared.htmlForBookId(book.id, chapter: chapter)
    }
    
    @State private var showMap = false
    
    
    var body: some View {
        WebView(html: html, request: nil)
            .injectNavigationHandler { geoPlaceId in
                print("User selected \(geoPlaceId)")
            }
            .navigationBarTitle(title())
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button(action: {
                showMap = true
            }, label: {
                Image(systemName: "map")
            }))
            .sheet(isPresented: $showMap) {
                MapOpenView(bookName: book.fullName, chapter: chapter, onDismiss: {
                    showMap = false
                })
            }
    }
    
    private func title() -> String {
        if chapter > 0 {
            return "\(book.fullName) \(chapter)"
        }
        else {
            return book.fullName
        }
    }
    
    func getGeoPlaces(bookId: Int, chapter: Int) -> [GeoPlace] {
        var places = [GeoPlace]()
        for scripture in GeoDatabase.shared.versesForScriptureBookId(bookId, chapter) {
            for (place, _) in GeoDatabase.shared.geoTagsForScriptureId(scripture.id) {
                places.append(place)
            }
        }
        
        return places
    }
}

struct ChapterContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChapterContentView(book: GeoDatabase.shared.bookForId(106), chapter: 10)
    }
}
