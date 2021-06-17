//
//  ArticleDetailVC.swift
//  GGAdvertsOptimization-DEV
//
//  Created by Apple on 6/17/21.
//  Copyright © 2021 Rikkeisoft. All rights reserved.
//

import UIKit
import WebKit

class ArticleDetailVC: UIViewController {
    
    @IBOutlet weak var naviBar: CustomNaviBar!
    @IBOutlet weak var webView: WKWebView!
    
    var indexArticle: Int = 0
    var titleArticle: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        naviBar.title = titleArticle
        setupWebView()
    }
    
    private func setupWebView(){
        if let pdfURL = Bundle.main.url(forResource: "article_1", withExtension: "pdf", subdirectory: nil, localization: nil)  {
            do {
                let data = try Data(contentsOf: pdfURL)
                webView.load(data, mimeType: "application/pdf", characterEncodingName:"", baseURL: pdfURL.deletingLastPathComponent())
            }
            catch {
                // catch errors here
            }
        }
    }
}
