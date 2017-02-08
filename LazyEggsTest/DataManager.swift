//
//  DataManager.swift
//  LazyEggsTest
//
//  Created by Noah Panicola on 2/7/17.
//  Copyright © 2017 self.edu. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import UIKit

protocol LEDataManagerDelegate {
    func LEDataManagerDidConnect()
    func LEDataManagerDidPullFoodItem( foodItem : LEFoodItem )
}

public class LEDataManager {
    static let sharedInstance = LEDataManager()
    
    var delegate: LEDataManagerDelegate?
    var connectionTimer: Timer?
    var databaseRef: FIRDatabaseReference!
    
    var isConnected : Bool = false
    
    func connect() {
        
        if let t = connectionTimer {
            t.invalidate()
        }
        
        connectionTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (t) in
            
            if FIRAuth.auth()?.currentUser != nil {
                self.isConnected = true
                self.delegate?.LEDataManagerDidConnect()
                self.connectionTimer?.invalidate()
                self.databaseRef = FIRDatabase.database().reference()
            }
        })
    }
    
    func pullAllFoodItems() {
        
        if self.isConnected == false { return }
        
        self.databaseRef.child("food_items").observe(.childAdded, with: { (snapshot) in
            
          
            
        })
    }
}
