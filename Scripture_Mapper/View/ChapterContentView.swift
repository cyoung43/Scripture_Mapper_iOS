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
    private var places : [GeoPlace]
    
    init(book: Book, chapter: Int) {
        self.book = book
        self.chapter = chapter
        places = [GeoPlace]()
        
        places.append(contentsOf: getGeoPlaces(bookId: book.id, chapter: chapter))
        print(places)
    }
    
    var body: some View {
        WebView(html: html, request: nil)
            .navigationBarTitle("\(book.fullName) \(chapter)")
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
