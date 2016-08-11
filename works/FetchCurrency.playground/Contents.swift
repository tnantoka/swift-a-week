//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

// select * from yahoo.finance.xchange where pair in ("USDJPY")
let urlString = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.xchange%20where%20pair%20in%20%28%22USDJPY%22%29&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"
let url = NSURL(string: urlString)!

let session = NSURLSession.sharedSession()
let task = session.dataTaskWithURL(url) { (data, response, error) in
    let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: [])
    let query = json["query"]!
    let results = query!["results"]!
    let rate = results!["rate"]!
    let usdjpy = rate!["Rate"] // "101.1950"
}
task.resume()

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true