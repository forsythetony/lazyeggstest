//
//  ViewController.swift
//  LazyEggsTest
//
//  Created by Noah Panicola on 1/31/17.
//  Copyright © 2017 self.edu. All rights reserved.
//

import UIKit
import GoogleSignIn
import FirebaseDatabase

class ViewController: UIViewController, GIDSignInUIDelegate {
    
    var ref: FIRDatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        GIDSignIn.sharedInstance().uiDelegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signInWithGoogle(_ sender: LineButton) {
        GIDSignIn.sharedInstance().signIn()
    }



}

