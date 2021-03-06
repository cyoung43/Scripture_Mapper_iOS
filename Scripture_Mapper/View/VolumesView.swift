//
//  VolumesView.swift
//  Scripture_Mapper
//
//  Created by Chris Young on 11/22/21.
//

import SwiftUI

struct VolumesView: View {
    @EnvironmentObject var scriptureMapper: ScriptureMapper
    
    var body: some View {
        List {
            let volumes = GeoDatabase.shared.volumes()
            
            ForEach(volumes.indices) { index in
                NavigationLink(volumes[index], destination: {
                    BooksForVolumeView(volumeId: index + 1, volumeName: volumes[index])
                })
                    .isDetailLink(false)
            }
        }
        .listStyle(.plain)
        .navigationBarTitle("The Scriptures")
    }
}

struct VolumesView_Previews: PreviewProvider {
    static var previews: some View {
        VolumesView()
    }
}
