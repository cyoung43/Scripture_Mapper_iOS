//
//  ChapterGridView.swift
//  Scripture_Mapper
//
//  Created by Chris Young on 11/22/21.
//

import SwiftUI

struct ChapterGridView: View {
    @EnvironmentObject var scriptureMapper: ScriptureMapper
    var book: Book
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: scriptureMapper.isDetailViewVisible ? 4 : 6), spacing: 8) {
                ForEach(1...(book.numChapters ?? 0), id: \.self) { chapter in
                    NavigationLink("\(chapter)") {
                        ChapterContentView(book: book, chapter: chapter)
                    }
                    .isDetailLink(false)
                    .buttonStyle(CoolButton())
                }
            }
        }
        .navigationTitle("\(book.fullName)")
        .navigationBarTitleDisplayMode(.inline)
    }
}
