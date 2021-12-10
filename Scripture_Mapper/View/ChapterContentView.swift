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
    private var html: String
    
    @State private var showMap = false
    @EnvironmentObject var scriptureMapper: ScriptureMapper
    
    init(book: Book, chapter: Int) {
        self.book = book
        self.chapter = chapter
        
        html = ScriptureRenderer.shared.htmlForBookId(book.id, chapter: chapter)
    }
    
    var body: some View {
        WebView(html: html, request: nil)
            .injectNavigationHandler { geoPlaceId in
                scriptureMapper.setCurrentGeoPlace(placeId: geoPlaceId)
                
                withAnimation {
                    scriptureMapper.setRegion(gPlaces: scriptureMapper.currentGeoPlaces)
                }
                
                if !scriptureMapper.isDetailViewVisible {
                    showMap = true
                }
            }
            .navigationBarTitle(title())
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing:
                Group {
                    if !scriptureMapper.isDetailViewVisible {
                        Button(action: {
                            showMap = true
                        }, label: {
                            Image(systemName: "map")
                        })
                    }
                }
            )
            .onAppear {
                scriptureMapper.setNavTitle(book.fullName, "\(chapter)")
                
                scriptureMapper.setGeocodedPlaces(ScriptureRenderer.shared.geoPlaces(for: book, chapter: chapter))
                
                scriptureMapper.setRegion(gPlaces: scriptureMapper.geoPlaces)
            }
            .sheet(isPresented: $showMap) {
                NavigationView {
                    MapOpenView(bookName: book.fullName, chapter: chapter, onDismiss: {
                        showMap = false
                    })
                        .onAppear {
                            scriptureMapper.setNavTitle(book.fullName, "\(chapter)")
                            // look at that spot
                            if scriptureMapper.currentGeoPlaces.count > 0 {
                                withAnimation {
                                    scriptureMapper.setRegion(gPlaces: scriptureMapper.currentGeoPlaces)
                                }
                            }
                            else {
                                scriptureMapper.setRegion(gPlaces: scriptureMapper.geoPlaces)
                            }
                        }
                        .edgesIgnoringSafeArea(.bottom)
                }
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
}

struct ChapterContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChapterContentView(book: GeoDatabase.shared.bookForId(106), chapter: 10)
    }
}
