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
    
    init(book: Book, chapter: Int) {
        self.book = book
        self.chapter = chapter
        
        html = ScriptureRenderer.shared.htmlForBookId(book.id, chapter: chapter)
    }
    
    var body: some View {
        WebView(html: html, request: nil)
            .navigationBarTitle("\(book.fullName) \(chapter)")
            .navigationBarTitleDisplayMode(.inline)
    }
}
