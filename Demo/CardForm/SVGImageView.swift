//
//  SVGImageView.swift
//  Demo
//
//  Created by Kerollos Nabil on 10/11/2024.
//

import SwiftUI
import WebKit

struct SVGImageView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        
        let request = URLRequest(url: url)
        webView.load(request)
        webView.isOpaque = false
        webView.backgroundColor = .clear
        
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: SVGImageView

        init(_ parent: SVGImageView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            let script = """
            var svg = document.querySelector('svg');
            svg.setAttribute('width', '\(webView.frame.width * 4)');
            svg.setAttribute('height', '\(webView.frame.height * 4)');

            """
            webView.evaluateJavaScript(script, completionHandler: nil)
        }
    }
}

#Preview {
    SVGImageView(url: URL(string: "https://staging-cdn.moneyhash.io/images/checkout_icons/forsachk.svg")!)
        .frame(width: 350, height: 250)
        
}
