//
//  DetailWebViewController.swift
//  Food2Fork
//
//  Created by Michael Redoble on 19/11/2017.
//  Copyright © 2017 mjredoble. All rights reserved.
//

import UIKit

class DetailWebViewController: UIViewController {
    
    var urlToOpen: String?
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL (string: urlToOpen!)
        let request = URLRequest(url: url!)
        webView.loadRequest(request)
    }

    
    @IBAction func onCloseButtonTap(_ sender: AnyObject) {
        self.dismiss(animated: true)
    }
}
