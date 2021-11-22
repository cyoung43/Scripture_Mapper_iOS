//
//  BooksForVolumeView.swift
//  Scripture_Mapper
//
//  Created by Chris Young on 11/22/21.
//

import SwiftUI

struct BooksForVolumeView: View {
    var volumeId: Int
    var volumeName: String
    
    var body: some View {
        List {
            Text("Genesis")
        }
    }
}

struct BooksForVolumeView_Previews: PreviewProvider {
    static var previews: some View {
        BooksForVolumeView(volumeId: 1, volumeName: "Old Testament")
    }
}
