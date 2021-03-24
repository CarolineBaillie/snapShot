//
//  CollectionViewYM.swift
//  snapShot
//
//  Created by Caroline Baillie on 1/24/21.
//

import Foundation
import UIKit
import Parse

class CollectionViewIT: UICollectionViewController {
    // memories that come in from previous
    var yr : String?
    var mn : String?
    var category : String?
    var mem : [Memory]! = []
    
    override func viewDidLoad() {
//        super.viewDidLoad()
        // update function based on prev input
        if ((self.category) != nil) {
            sessionManager.shared.GetMemByCat(category: self.category!) { (success) in }
            self.mem = sessionManager.shared.memoriesCat
        } else {
            sessionManager.shared.GetMemByYM(year: self.yr!, months: self.mn!) { (success) in }
            self.mem = sessionManager.shared.memoriesYM
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mem.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCellCollection", for: indexPath) as! CustomCellCollection
        customCell.memImage.image = mem[indexPath.row].Image
        customCell.memTitle.text = mem[indexPath.row].title
        return customCell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Create an instance of PlayerTableViewController and pass the variable
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let row = indexPath.row
        // Instantiate the desired view controller from the storyboard using the view controllers identifier
        // Cast is as the custom view controller type you created in order to access it's properties and methods
        let customViewController = storyboard.instantiateViewController(withIdentifier: "memInfoPage") as! memInfoPage
        customViewController.page = mem[indexPath.row]
        self.navigationController?.pushViewController(customViewController, animated: true)
    }
}
