//
//  IssuesViewController.swift
//  GitHubIssuesWithBond
//
//  Created by Tatsuya Tobioka on 2015/12/29.
//  Copyright © 2015年 tnantoka. All rights reserved.
//

import UIKit

import Bond

class IssuesViewController: UITableViewController {

    let viewModel = IssuesViewModel()
    var dataSource: ObservableArray<ObservableArray<IssuesCellViewModel>>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        title = NSLocalizedString("Issues", comment: "")
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44.0
        
        dataSource = ObservableArray([viewModel.cellViewModels])
        dataSource.bindTo(tableView, proxyDataSource: self) { [unowned self] indexPath, dataSource, tableView -> UITableViewCell in
            let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
            cell.textLabel?.numberOfLines = 0
            
            let cellVM = dataSource[indexPath.section][indexPath.row]
            cellVM.title.bindTo(cell.textLabel!.bnd_text).disposeIn(cell.bnd_bag)
            cellVM.detail.bindTo(cell.detailTextLabel!.bnd_text).disposeIn(cell.bnd_bag)
            
            if indexPath.row == self.viewModel.cellViewModels.count - 1 {
                self.viewModel.loadNext()
            }
            
            return cell
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        guard let cell = sender as? UITableViewCell else { return }
        guard let indexPath = tableView.indexPathForCell(cell) else { return }
        guard let webController = segue.destinationViewController as? WebViewController else { return }
        let cellVM = dataSource[indexPath.section][indexPath.row]
        webController.url = cellVM.htmlURL
    }
}

extension IssuesViewController: BNDTableViewProxyDataSource {
    func shouldReloadInsteadOfUpdateTableView(tableView: UITableView) -> Bool {
        return true
    }
}