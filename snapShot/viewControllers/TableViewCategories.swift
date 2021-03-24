//
//  TableViewCategories.swift
//  snapShot
//
//  Created by Caroline Baillie on 1/4/21.
//

import Foundation
import UIKit
import MapKit

class TableViewCategories : UITableViewController {
    
    var cat = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // get all categories
        sessionManager.shared.GetCategories { (success) in }
        self.cat = sessionManager.shared.categories
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cat.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomCell
        let category = cat[indexPath.row]
        customCell.cellLabelCat.text = category
        return customCell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Create a variable that you want to send based on the destination view controller
        // You can get a reference to the data by using indexPath shown below
        
        let c = cat[indexPath.row]

        // Create an instance of PlayerTableViewController and pass the variable
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        // Instantiate the desired view controller from the storyboard using the view controllers identifier
        // Cast is as the custom view controller type you created in order to access it's properties and methods
        let customViewController = storyboard.instantiateViewController(withIdentifier: "CollectionViewIT") as! CollectionViewIT
        customViewController.category = c
        self.navigationController?.pushViewController(customViewController, animated: true)
    }
}
