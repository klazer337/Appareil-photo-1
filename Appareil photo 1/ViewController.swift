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
        imagePicker.allowsEditing = false // true si besoin
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if imageViewChoisi.image == nil {
            nosImagesLabel.isHidden = false
        } else {
            nosImagesLabel.isHidden = true
        }
    }
    
    func presentWithSource(_ source: UIImagePickerController.SourceType) {      // source que l'on doit envoyer
        imagePicker.sourceType = source
        present(imagePicker,animated: true,completion: nil)
    }

    @IBAction func prendrePhoto(_ sender: UIButton) {
        let alerteActionSheet = UIAlertController(title: "Prendre une photo", message: "Choisissez le média", preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "Appareil photo", style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {                     // on vérifie si u appareil photo est disponible
                self.presentWithSource(.camera)
            } else {                                                                        // Si il n'y a pas d'appareil photo disponible
                let alerte = UIAlertController(title: "Erreur", message: "Aucun appareil photo n'est disponible", preferredStyle: .alert)
                let annuler = UIAlertAction(title: "Je comprends", style: .destructive, handler: nil)
                alerte.addAction(annuler)
                self.present(alerte, animated: true, completion: nil)
            }
        }
        let gallerie = UIAlertAction(title: "Galerie de photos", style: .default) { (action) in
            self.presentWithSource(.photoLibrary)
        }
        let cancel = UIAlertAction(title: "Annuler", style: .cancel, handler: nil)
        alerteActionSheet.addAction(camera)
        alerteActionSheet.addAction(gallerie)
        alerteActionSheet.addAction(cancel)
        
        if let popover = alerteActionSheet.popoverPresentationController {      // pour empecher un crash sur iPad
            popover.sourceView = view
            popover.sourceRect = CGRect(x: view.frame.midX, y: view.frame.midY, width: 0, height: 0)
            popover.permittedArrowDirections = []
        }
        present(alerteActionSheet,animated: true,completion: nil)
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

