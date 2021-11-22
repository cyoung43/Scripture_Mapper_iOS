//
//  VolumesView.swift
//  Scripture_Mapper
//
//  Created by Chris Young on 11/22/21.
//

import SwiftUI

struct VolumesView: View {
    var body: some View {
        List {
            ForEach(GeoDatabase.shared.volumes(), id: \.self) { volume in
                NavigationLink(volume, destination: {
                    BooksForVolumeView(volumeName: volume)
                })
            }
        }
    }
}

struct VolumesView_Previews: PreviewProvider {
    static var previews: some View {
        VolumesView()
    }
}
