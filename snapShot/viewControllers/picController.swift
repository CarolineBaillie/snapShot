//
//  picController.swift
//  snapShot
//
//  Created by Caroline Baillie on 2/22/21.
//

import Foundation
import UIKit

class picController: UIViewController {
    
    @IBOutlet weak var img: UIImageView!
    
    let pickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pickerController.sourceType = UIImagePickerController.SourceType.camera
        pickerController.delegate = self
    }
    
    @IBAction func onClickTakePic(_ sender: Any) {
        present(pickerController, animated: true, completion: nil)
    }
}

extension picController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            img.image = image
            dismiss(animated: true, completion: nil)
            // send image to create new mem
            let obj = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "newMemory") as! newMemory
            obj.image = image
            self.present(obj, animated: true, completion: nil)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //close out (camera has been closed)
    }
}
