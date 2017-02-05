//
//  ViewController.swift
//  HelloRxSwift
//
//  Created by Tatsuya Tobioka on 2/4/17.
//  Copyright © 2017 tnantoka. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var countLabel: UILabel!
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let count = textView.rx.text.orEmpty
            .distinctUntilChanged()
            .map { $0.characters.count }
            .shareReplay(1)
        count.map { $0.description }
            .bindTo(countLabel.rx.text)
            .addDisposableTo(disposeBag)
        count.map { $0 > 50 }
            .map { $0 ? .red : .black }
            .subscribe(onNext: { self.countLabel.textColor = $0 })
            .addDisposableTo(disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

