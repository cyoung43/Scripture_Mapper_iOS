//
//  ChapterGridView.swift
//  Scripture_Mapper
//
//  Created by Chris Young on 11/22/21.
//

import SwiftUI

struct ChapterGridView: View {
    var book: Book
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 6), spacing: 8) {
                ForEach(1...book.numChapters ?? 0, id: \.self) { chapter in
                    Button {
                        
                    } label: {
                        Text("\(chapter)")
                    }
                }
            }
        }
    }
}
