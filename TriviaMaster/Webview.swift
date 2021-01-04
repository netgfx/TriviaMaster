//
//  Webview.swift
//  TriviaMaster
//
//  Created by Mixalis Dobekidis on 21/12/20.
//

import Foundation
import WebKit
import SwiftUI


/// View created as a workaround implementation of UIWebView for SwiftUI
struct WebView: UIViewRepresentable {

    /// String representation of the URL you want to open in the WebView.
    let urlString: String?

    func makeUIView(context: Context) -> WKWebView {
        let wkView = WKWebView()
        wkView.backgroundColor = .clear
        return wkView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let safeString = urlString, let url = URL(string: safeString) {
            let request = URLRequest(url: url)
            print("loading... \(url)")
            uiView.load(request)
        }
    }

}
