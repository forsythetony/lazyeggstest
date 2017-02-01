//
//  HomeViewController.swift
//  LazyEggsTest
//
//  Created by Tony Forsythe on 1/31/17.
//  Copyright © 2017 self.edu. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {

    @IBOutlet weak var mainTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTextView.text = ""
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func didTapYesHackTime(_ sender: Any) {
        
        //  Here you should make a call to retrieve all the food items
        
        //  First get the reference to the databasef
        let dbRef = FIRDatabase.database().reference()
        
        let _ = dbRef.child("food_items").observe(.childAdded, with: { (snapshot) in
            
            guard let snap_value = snapshot.value as? Dictionary<String, AnyObject> else { return }
            
            var currentText = self.mainTextView.text
            
            currentText = currentText! + snap_value.description
            
            
            self.mainTextView.text = currentText
        
        
        })
        
        
        
        
        
        
    }
    @IBAction func didTapNoHackTime(_ sender: Any) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
