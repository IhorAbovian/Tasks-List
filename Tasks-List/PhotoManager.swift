//
//  File.swift
//  CoreDataSpisokDel
//
//  Created by Igor Abovyan on 07.10.2021.
//

import UIKit

protocol PhotoManagerDelegate {
    func getPhoto(photo: UIImage)
}

class PhotoManager: NSObject {
    
    var viewController: UIViewController!
    var myDelegate: PhotoManagerDelegate!
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    
    func takePhoto() {
        let vc = UIImagePickerController.init()
        vc.sourceType = .camera
        vc.delegate = self
        self.viewController.present(vc, animated: true)
    }
    
    func choosePhoto() {
        let vc = UIImagePickerController.init()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        self.viewController.present(vc, animated: true)
    }
}


//
extension PhotoManager: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let photo = info[.originalImage] as? UIImage {
            myDelegate.getPhoto(photo: photo)
        }
        
        viewController.dismiss(animated: true)
        
    }
}
