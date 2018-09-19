//
//  ViewController.swift
//  Appareil photo 1
//
//  Created by Kevin Trebossen on 19/09/18.
//  Copyright © 2018 KTD. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageViewChoisi: UIImageView!
    @IBOutlet weak var nosImagesLabel: UILabel!
    
    var imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
    }

    @IBAction func prendrePhoto(_ sender: UIButton) {
    }
    
}


extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let edite = info[.editedImage] as? UIImage {     // image éditée
            imageViewChoisi.image = edite
        } else if let originale = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {     // ou image originale
            imageViewChoisi.image = originale
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}

