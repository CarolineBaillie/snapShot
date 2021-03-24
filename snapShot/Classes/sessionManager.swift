//
//  sessionManager.swift
//  snapShot
//
//  Created by Caroline Baillie on 1/4/21.
//

import Foundation
import Parse
class sessionManager: NSObject {
    // allows access from other files
    static let shared = sessionManager()
    
    var memories : [Memory]! = []
    var years : [String]! = []
    var categories : [String]! = []
    var memoriesYM : [Memory]! = []
    var memoriesCat : [Memory]! = []
    var currentCoord : CLLocationCoordinate2D?
    
    var user : currentUser!
    
    override init() {
       super.init()
    }
    
    // get memories by year and months
    func GetMemByYM(year:String,months:String,completion:@escaping (_ success:Bool) -> ()){
        var memoriesSample : [Memory]! = []
        for mem in memories {
            let d = mem.date
            let array = d.components(separatedBy: "/")
            let y = array[2]
            let m = array[0]
            var monthsArray = [String]()
            if months == "Jan-March" {
                monthsArray = ["1","2","3"]
            } else if months == "April-June" {
                monthsArray = ["4","5","6"]
            } else if months == "July-Aug" {
                monthsArray = ["7","8","9"]
            } else if months == "Oct-Dec" {
                monthsArray = ["10","11","12"]
            }
            if (y == year && monthsArray.contains(m)) {
                memoriesSample.append(mem)
            }
        }
        memoriesYM = memoriesSample
        print(memoriesYM)
        completion(true)
    }
    // get memories by category
    func GetMemByCat(category:String,completion:@escaping (_ success:Bool) -> ()){
        var memoriesSample : [Memory]! = []
        for mem in memories {
            let c = mem.category
            if (c == category) {
                memoriesSample.append(mem)
            }
        }
        memoriesCat = memoriesSample
        completion(true)
    }
    // get all memories
    func GetAllMem(completion:@escaping (_ success:Bool) -> ()){
        // clear previous data
        memories.removeAll()
        // get all rows
        let query = PFQuery(className: "Memory")
        // where user is equal to current user
        query.whereKey("userID", equalTo:user.id)
        query.findObjectsInBackground { (objects, error) in
            // no errors
            if error == nil {
                // if there are objects in the array
                if let returnedObjects = objects {
                    // loop through all objects in array
                    for object in returnedObjects {
                        // extract the image
                        let file = object["Image"] as! PFFileObject
                        file.getDataInBackground { (imageData: Data?, error: Error?) in
                            if error == nil {
                                if let imageData = imageData {
                                    let image = UIImage(data: imageData)
                                    // convert coord of type GeoPoint to CLLocationCoordinate2D
                                    let coor = object["coordinate"]! as! PFGeoPoint
                                    let coord = CLLocationCoordinate2D(latitude: coor.latitude, longitude: coor.longitude)
                                    // create a new memory
                                    let memData = Memory(title: object["title"]! as! String, Image: (image ?? UIImage(named: "test"))!, coordinate: coord, desc: object["desc"]! as! String, category: object["category"]! as! String, tags: object["tags"]! as! String, location: object["location"]! as! String, date: object["date"]! as! String, objID: object.objectId!)
                                    // add memory to the global array
                                    self.memories.append(memData)
                                }
                            }
                        }
                    }
                }
                completion(true)
            }
            else {
                //return false completion if fails
                completion(false)
            }
        }
    }
    
    func GetYears(completion:@escaping (_ success:Bool) -> ()){
        var yearsSample : [String]! = []
        for mem in memories {
            let d = mem.date
            let array = d.components(separatedBy: "/")
            let y = array[2]
            if !yearsSample.contains(y) {
                // add to array
                yearsSample.append(y)
            }
        }
        years = yearsSample
        completion(true)
    }
    func GetCategories(completion:@escaping (_ success:Bool) -> ()){
        var catSample : [String]! = []
        for mem in memories {
            let c = mem.category
            if !catSample.contains(c!) {
                // add to array
                catSample.append(c!)
            }
        }
        categories = catSample
        completion(true)
    }
    
    func saveMemory (memory:Memory, completion:@escaping (_ success:Bool) -> ()) {
        // set values for new memory
        let mem = PFObject(className:"Memory")
        mem["title"] = memory.title
        mem["desc"] = memory.desc
        mem["location"] = memory.location
        mem["date"] = memory.date
        mem["userID"] = user.id
        mem["tags"] = memory.tags
        mem["category"] = memory.category
        mem["coordinate"] = PFGeoPoint(latitude: memory.coordinate.latitude, longitude: memory.coordinate.longitude)
        // reducing image size
        let image = memory.Image
        let actualHeight:CGFloat = image.size.height
        let actualWidth:CGFloat = image.size.width
        let imgRatio:CGFloat = actualWidth/actualHeight
        let maxWidth:CGFloat = 1024.0
        let resizedHeight:CGFloat = maxWidth/imgRatio
        let compressionQuality:CGFloat = 0.5
        let rect:CGRect = CGRect(x: 0, y: 0, width: maxWidth, height: resizedHeight)
        UIGraphicsBeginImageContext(rect.size)
        image.draw(in: rect)
        let img: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        let imageData:Data = img.jpegData(compressionQuality: compressionQuality)!
        UIGraphicsEndImageContext()
        let imageFinal = UIImage(data: imageData)!
        // preping to save image
        let imgData = imageFinal.pngData()
        let imageFile = PFFileObject(name:"image.png", data:imgData!)
        mem["Image"] = imageFile
        // save all
        mem.saveInBackground { (succeeded, error)  in
            if (succeeded) {
//                The object has been saved.
                memory.objID = mem.objectId as! String
                self.memories.append(memory)
                completion(true)
            } else {
                // There was a problem
                completion(false)
            }
        }
    }
    
    
    func updateMemory (memory:Memory, completion:@escaping (_ success:Bool) -> ()) {
        // find memory
        let query = PFQuery(className:"Memory")
        // with the same objectID
        query.getObjectInBackground(withId: memory.objID) { (object, error) in
            if error == nil {
                // Success!
                if let object = object {
                    // update all values
                    object["title"] = memory.title
                    object["desc"] = memory.desc
                    object["location"] = memory.location
                    object["date"] = memory.date
                    object["tags"] = memory.tags
                    object["category"] = memory.category
                }
                // save object
                object!.saveInBackground()
                // change in global array
                self.updateMemArray(memory: memory)
                completion(true)
            } else {
                // Fail!
                completion(false)
            }
        }
    }
    
    func updateMemArray(memory:Memory) {
        // loop through memories
        for m in memories {
            // if objectIDs the same
            if m.objID == memory.objID {
                // update that memory in the global array
                m.title = memory.title
                m.desc = memory.desc
                m.location = memory.location
                m.date = memory.date
                m.tags = memory.tags
                m.category = memory.category
            }
        }
    }
    
    func deleteMemory (memory:Memory, completion:@escaping (_ success:Bool) -> ()) {
        // get the memory
        let query = PFQuery(className:"Memory")
        query.getObjectInBackground(withId: memory.objID) { (object, error) in
            if error == nil {
                // Success!
                if let object = object {
                    // delete this row
                    object.deleteInBackground()
                    // delete from array memories
                    self.deleteMemArray(memory: memory)
                }
                completion(true)
            } else {
                // Fail!
                completion(false)
            }
        }
    }
    
    func deleteMemArray(memory:Memory) {
        // loop through all memories in array
        for i in 0..<memories.count-1 {
            // if the objectIDs match
            if memories[i].objID == memory.objID {
                // delete the memory
                memories.remove(at: i)
            }
        }
    }
}
