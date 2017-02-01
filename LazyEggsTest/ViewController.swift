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

class ViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    
    var databaseRef: FIRDatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication: sourceApplication,
                                                 annotation: annotation)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        
        if let error = error {
            print("error: " + error.localizedDescription)
            return
        }
        print("User signed into Google\n")
        
        guard let authentication = user.authentication else { return }
        let credential = FIRGoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        FIRAuth.auth()?.signIn(with: credential) { (user, error) in
            
            if let error = error {
                print("error1234: " + error.localizedDescription)
                return
            }
            
            print("User signed into Firebase")
            self.databaseRef = FIRDatabase.database().reference()
            self.databaseRef.child("user_profiles").child(user!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                let snapshot = snapshot.value as? NSDictionary
                if snapshot == nil{
                    self.databaseRef.child("user_profiles").child("name").setValue(user?.displayName)
                    self.databaseRef.child("user_profiles").child("email").setValue(user?.email)
                }
                
                
            })
            
            self.performSegue(withIdentifier: Constants.Segues.SignInToHome, sender: nil)
            
            
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        
    }
    
    func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any])
        -> Bool {
            return GIDSignIn.sharedInstance().handle(url,
                                                     sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                     annotation: [:])
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signInWithGoogle(_ sender: LineButton) {
        GIDSignIn.sharedInstance().signIn()
    }



}

