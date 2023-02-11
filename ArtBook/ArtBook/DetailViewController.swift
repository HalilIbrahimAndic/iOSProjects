//
//  DetailViewController.swift
//  ArtBook
//
//  Created by Halil Ibrahim Andic on 11.02.2023.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var artistText: UITextField!
    @IBOutlet weak var yearText: UITextField!
    @IBOutlet weak var button: UIButton!
    
    var chosenPainting = ""
    var chosenPaintingID: UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //hide save button at the beginning
        button.isHidden = true

        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        
        imageView.isUserInteractionEnabled = true
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(imageTapRecognizer)
        
        //show data
        if chosenPainting != "" {
            retrieveData(chosenPaintingID!)
        }
    }
    
    func retrieveData(_ id: UUID) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let idString = chosenPaintingID?.uuidString
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
        fetchRequest.returnsObjectsAsFaults = false
        
        fetchRequest.predicate = NSPredicate(format: "id = %@", idString!)
        
        do {
            let results = try context.fetch(fetchRequest)
            
            for result in results as! [NSManagedObject] {
                
                if let name = result.value(forKey: "name") as? String {
                    nameText.text = name
                }
                
                if let artist = result.value(forKey: "artist") as? String {
                    artistText.text = artist
                }
                
                if let year = result.value(forKey: "year") as? Int {
                    yearText.text = String(year)
                }
                
                if let imageData = result.value(forKey: "image") as? Data {
                    let image = UIImage(data: imageData)
                    imageView.image = image
                }
            }
        } catch {
            print("Error: \(error)")
        }
        
    }
    
    @objc func selectImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true //editing
        present(picker, animated: true, completion: nil)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newPainting = NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: context)
        
        //Attributes
        newPainting.setValue(nameText.text!, forKey: "name")
        newPainting.setValue(artistText.text!, forKey: "artist")
        newPainting.setValue(UUID(), forKey: "id")
        
        if let year = Int(yearText.text!) {
            newPainting.setValue(year, forKey: "year")
        }
        
        let data = imageView.image!.jpegData(compressionQuality: 0.5)
        newPainting.setValue(data, forKey: "image")
        
        // save context
        do {
            try context.save()
        } catch {
            print("error: \(error)")
        }

        self.navigationController?.popViewController(animated: true)
    }

}

//MARK: - Extensions
extension DetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage  // I'm not 100% sure that user selected an image. so used as? casting
        self.dismiss(animated: true, completion: nil)
        
        button.isHidden = false
    }
}
