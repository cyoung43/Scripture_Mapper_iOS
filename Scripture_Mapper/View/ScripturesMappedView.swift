//
//  ContentView.swift
//  Scripture_Mapper
//
//  Created by Chris Young on 11/22/21.
//

import SwiftUI

struct ScripturesMappedView: View {
    var body: some View {
        NavigationView {
            VolumesView()
                .navigationBarTitle("The Scriptures")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ScripturesMappedView()
    }
}
