//
//  TableViewYear.swift
//  snapShot
//
//  Created by Caroline Baillie on 1/4/21.
//

import Foundation
import UIKit
import MapKit

class TableViewYears : UITableViewController {
    
    var ys = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // update the years function
        sessionManager.shared.GetYears { (success) in }
        //get the variables from sessionManager
        self.ys = sessionManager.shared.years
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ys.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomCell
        let year = ys[indexPath.row]
        customCell.cellLabelYear.text = year
        return customCell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Create a variable that you want to send based on the destination view controller
        // You can get a reference to the data by using indexPath shown below
        
        let year = ys[indexPath.row]

        // Create an instance of PlayerTableViewController and pass the variable
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        // Instantiate the desired view controller from the storyboard using the view controllers identifier
        // Cast is as the custom view controller type you created in order to access it's properties and methods
        let customViewController = storyboard.instantiateViewController(withIdentifier: "TableViewMonths") as! TableViewMonths
        customViewController.yr = year
        self.navigationController?.pushViewController(customViewController, animated: true)
    }
}
