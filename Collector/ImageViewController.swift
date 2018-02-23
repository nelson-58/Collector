//
//  ImageViewController.swift
//  Collector
//
//  Created by Andy Harris on 23/02/2018.
//  Copyright © 2018 Andy Harris. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    // this class has beeen delegated to handle UIImagePicker and UINavigationController
    
    @IBOutlet weak var itemImageHolder: UIImageView!
    
    
    @IBOutlet weak var titleTextField: UITextField!
    
    // define an object in image picker class
    var imagePicker = UIImagePickerController()
    
    
    @IBAction func addButtonTapped(_ sender: Any) {
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
         
            // create an object of type Item in core data
            let item = Item(entity:Item.entity(),insertInto: context)
            // put the title text in (from the textfield on the sreen
            item.title = titleTextField.text
            
            // if an image has been selected ..
            if let image = itemImageHolder.image {
                // convert it to PNG data
                if let imageData = UIImagePNGRepresentation(image){
                    // and if that's OK, save it to the new object
                    item.image = imageData
                }
            }
            // then save the context into persistent data
            try? context.save()
            // and pop back a screen
            navigationController?.popViewController(animated: true)
        }
        
    }
    
    @IBAction func showFoldersIconTapped(_ sender: Any) {
        
        imagePicker.sourceType = .photoLibrary
        // present the picker controller to the user
        present(imagePicker,animated: true, completion: nil)
        
    }
    
    @IBAction func showCameraIconTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        // needs a real camera
        // present picker to the user
        present(imagePicker,animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // delegate this class to handle UIImagePicker and UINavigationController
        imagePicker.delegate = self
        
        // Do any additional setup after loading the view.
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // pick out the image stored in "info" dictionary by the image picker
        
        if let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            // if we have an image, put in image view on screen
            itemImageHolder.image = chosenImage
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
