//
//  AIUtil.swift
//  snapShot
//
//  Created by Caroline Baillie on 1/23/21.
//

import UIKit

fileprivate var aView : UIView?

extension UIViewController {
    func showSpinner(){
        aView = UIView(frame: self.view.bounds)
        aView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        //create activity view indicator
        let ai = UIActivityIndicatorView(style: .whiteLarge)
        ai.center = aView!.center
        ai.startAnimating()
        aView?.addSubview(ai)
        self.view.addSubview(aView!)
    }
    func removeSpinner() {
        aView?.removeFromSuperview()
        aView = nil
    }
}
