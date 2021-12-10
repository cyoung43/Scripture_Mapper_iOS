//
//  ChapterButton.swift
//  Scripture_Mapper
//
//  Created by Chris Young on 12/9/21.
//

import SwiftUI

// adapted from https://www.hackingwithswift.com/quick-start/swiftui/customizing-button-with-buttonstyle
struct CoolButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(.white)
            .foregroundColor(.blue)
            .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(.blue, lineWidth: 1.5))
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct ChapterButton: View {
    var text: String
    var chapterNav: () -> ()
    
    var body: some View {
        Button("\(text)") {
            chapterNav()
        }
        .buttonStyle(CoolButton())
    }
}

struct ChapterButton_Previews: PreviewProvider {
    static var previews: some View {
        ChapterButton(text: "Jericho", chapterNav: { })
    }
}
