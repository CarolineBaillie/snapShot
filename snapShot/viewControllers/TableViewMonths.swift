//
//  TableViewMonths.swift
//  snapShot
//
//  Created by Caroline Baillie on 1/4/21.
//

import Foundation
import UIKit
import MapKit

class TableViewMonths : UITableViewController {
    var yr : String?
    var mn = ["Jan-March", "April-June", "July-Aug", "Oct-Dec"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mn.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomCell
        let month = mn[indexPath.row]
        customCell.cellLabelMonth.text = month
        return customCell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Create a variable that you want to send based on the destination view controller
        // You can get a reference to the data by using indexPath shown below
        
        let month = mn[indexPath.row]
        let year = yr

        // Create an instance of PlayerTableViewController and pass the variable
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        // Instantiate the desired view controller from the storyboard using the view controllers identifier
        // Cast is as the custom view controller type you created in order to access it's properties and methods
        let customViewController = storyboard.instantiateViewController(withIdentifier: "CollectionViewIT") as! CollectionViewIT
        customViewController.yr = year
        customViewController.mn = month
        self.navigationController?.pushViewController(customViewController, animated: true)
    }
}
