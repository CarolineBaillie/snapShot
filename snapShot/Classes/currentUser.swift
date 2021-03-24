//
//  currentUser.swift
//  snapShot
//
//  Created by Caroline Baillie on 1/23/21.
//

import Foundation
import UIKit
import Parse

class currentUser : NSObject {
    var username:String
    var id:String
    
    init(username:String, id:String) {
        self.username = username
        self.id = id
    }
}
