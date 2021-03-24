//
//  Memory.swift
//  snapShot
//
//  Created by Caroline Baillie on 12/27/20.
//

import UIKit
import MapKit

class Memory: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var desc: String
    var category: String?
    var tags: String?
    var location: String
    var date: String
    var Image: UIImage
    var objID: String
    
    init(title:String, Image:UIImage, coordinate:CLLocationCoordinate2D,desc:String,category:String,tags:String, location:String,date:String, objID:String){
        self.title = title
        self.Image = Image
        self.coordinate = coordinate
        self.desc = desc
        self.category = category
        self.tags = tags
        self.location = location
        self.date = date
        self.objID = objID
    }
}
