//
//  HomeViewController.swift
//  LazyEggsTest
//
//  Created by Tony Forsythe on 1/31/17.
//  Copyright © 2017 self.edu. All rights reserved.
//

import UIKit
import Firebase

//  Types of database calls
enum DatabaseCall : String {
    case PullFoodItems              = "Pull Food Items"
    case PullUserSettings           = "Pull User Settings"
    case PullRestaurantInformation  = "Pull Restaurant Information"
}

let databaseCalls = [
    DatabaseCall.PullFoodItems,
    DatabaseCall.PullUserSettings,
    DatabaseCall.PullRestaurantInformation ]


class HomeViewController: UIViewController {
    
    @IBOutlet weak var databaseCallsTableView: UITableView!
    
    let dataMan : LEDataManager = LEDataManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    //  MARK: Setup Functions
    func _setup() {
        _setupTableView()
        _setupSingletons()
    }
    
    func _setupTableView() {
        self.databaseCallsTableView.dataSource  = self
        self.databaseCallsTableView.delegate    = self
    }
    
    func _setupSingletons() {
        
        self.dataMan.delegate = self
        
        self.dataMan.connect()
    }
}




extension HomeViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return databaseCalls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = databaseCalls[indexPath.row].rawValue
        
        return cell
    }
}


extension HomeViewController : LEDataManagerDelegate {
    
    func LEDataManagerDidPullFoodItem(foodItem: LEFoodItem) {
        
        
    }
    
    func LEDataManagerDidConnect() {
        self.dataMan.pullAllFoodItems()
    }
}
