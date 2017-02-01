//
//  ViewController.swift
//  LazyEggsTest
//
//  Created by Noah Panicola on 1/31/17.
//  Copyright © 2017 self.edu. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import FirebaseDatabase
import GoogleSignIn

class ViewController: UIViewController, GIDSignInUIDelegate {
    
    var databaseRef: FIRDatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        GIDSignIn.sharedInstance().uiDelegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.checkUserStatus()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signInWithGoogle(_ sender: LineButton) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    func checkUserStatus(){
        
        if FIRAuth.auth()?.currentUser != nil {
            
            presentHome()
        } else {
            
            //User Not logged in
        }
    }
    func presentHome(){
        
        self.performSegue(withIdentifier: Constants.Segues.SignInToHome, sender: nil)
    }

}

