//
//  WebViewController.swift
//  GitHubIssuesWithBond
//
//  Created by Tatsuya Tobioka on 2015/12/30.
//  Copyright © 2015年 tnantoka. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {

    var url: NSURL?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let webView = view as? UIWebView else { return }
        guard let url = url else { return }
        
        webView.delegate = self
        
        let request = NSURLRequest(URL: url)
        webView.loadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - UIWebViewDelegate
    
    func webViewDidFinishLoad(webView: UIWebView) {
        title = webView.stringByEvaluatingJavaScriptFromString("document.title")
    }
}
