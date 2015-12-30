//
//  HomeViewController.swift
//  GitHubIssuesWithBond
//
//  Created by Tatsuya Tobioka on 2015/12/26.
//  Copyright © 2015年 tnantoka. All rights reserved.
//

import UIKit

import Bond

class HomeViewController: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var issuesButton: UIButton!
    @IBOutlet weak var signOutButton: UIButton!
    
    let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        viewModel.avatar.bindTo(avatarImageView.bnd_image)
        viewModel.username.bindTo(usernameLabel.bnd_text)
        
        viewModel.state.observe { [unowned self] state in
            dispatch_async(dispatch_get_main_queue()) {
                switch state {
                case .SignedOut:
                    self.signInButton.enabled = true
                    self.issuesButton.enabled = false
                    self.signOutButton.enabled = false
                case .SignedIn:
                    self.signInButton.enabled = false
                    self.issuesButton.enabled = true
                    self.signOutButton.enabled = true
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Actions
    @IBAction func signInButtonDidTap(sender: AnyObject) {
        viewModel.signIn()
    }
    
    @IBAction func signOutButtonDidTap(sender: AnyObject) {
        viewModel.signOut()
    }
}

