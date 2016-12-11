//
//  HandwritingViewController.swift
//  Swift-AI-iOS
//
//  Created by Collin Hundley on 12/3/15.
//

import UIKit

class HandwritingViewController: UIViewController {
    
    let handwritingView = HandwritingView()
    
    override func loadView() {
        self.view = self.handwritingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
