//
//  WebVieW.swift
//  Scripture_Mapper
//
//  Created by Chris Young on 11/22/21.
//

import SwiftUI
import MapKit
import WebKit

struct WebView: UIViewRepresentable {
    let html: String?
    let request: URLRequest?
    
    func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let html = html {
            uiView.loadHTMLString(html, baseURL: nil)
        }
        else if let request = request {
            uiView.load(request)
        }
    }
}

struct WebVie_Previews: PreviewProvider {
    static var previews: some View {
        WebView(html: nil, request: URLRequest(url: URL(string: "https://www.byu.edu")!))
    }
}
