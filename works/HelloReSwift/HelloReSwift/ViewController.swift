//
//  ViewController.swift
//  HelloReSwift
//
//  Created by Tatsuya Tobioka on 10/28/16.
//  Copyright © 2016 tnantoka. All rights reserved.
//

import UIKit

import ReSwift

class ViewController: UIViewController, StoreSubscriber {

    @IBOutlet weak var counterLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainStore.subscribe(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mainStore.unsubscribe(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func increment(_ sender: AnyObject) {
        mainStore.dispatch(
            CounterActionIncrease()
        )
    }

    @IBAction func decrement(_ sender: AnyObject) {
        mainStore.dispatch(
            CounterActionDecrease()
        )
    }
    
    // MARK: StoreSubscriber
    
    func newState(state: AppState) {
        counterLabel.text = "\(state.counter)"
    }
}

