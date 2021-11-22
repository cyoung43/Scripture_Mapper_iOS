//
//  BooksForVolumeView.swift
//  Scripture_Mapper
//
//  Created by Chris Young on 11/22/21.
//

import SwiftUI

struct BooksForVolumeView: View {
    var volumeName: String
    
    var body: some View {
        List {
            Text("Genesis")
        }
    }
}

struct BooksForVolumeView_Previews: PreviewProvider {
    static var previews: some View {
        BooksForVolumeView(volumeName: "Old Testament")
    }
}
