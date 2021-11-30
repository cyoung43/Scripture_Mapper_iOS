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
    private let coordinator = Coordinator()
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        
        webView.navigationDelegate = coordinator
        
        return webView
    }
    
    func makeCoordinator() -> Coordinator {
        coordinator
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let html = html {
            uiView.loadHTMLString(html, baseURL: nil)
        }
        else if let request = request {
            uiView.load(request)
        }
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            print("navigation action: \(navigationAction.request.url?.absoluteString ?? nil)")
        }
    }
}

struct WebVie_Previews: PreviewProvider {
    static var previews: some View {
        WebView(html: nil, request: URLRequest(url: URL(string: "https://www.byu.edu")!))
    }
}
