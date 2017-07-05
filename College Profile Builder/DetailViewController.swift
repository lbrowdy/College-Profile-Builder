//
//  DetailViewController.swift
//  College Profile Builder
//
//  Created by Brian Browdy on 7/3/17.
//  Copyright © 2017 Lily Browdy. All rights reserved.
//

import UIKit
import RealmSwift
import SafariServices

class DetailViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var enrollmentTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var websiteTextField: UITextField!
    let imagePicker = UIImagePickerController()
    
     let realm = try! Realm()

    var detailItem: College? {
        didSet {
            // Update the view.
            configureView()
        }
    }
  

    override func viewDidLoad() {
        super.viewDidLoad()
          imagePicker.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePicker.dismiss(animated: true) {
            let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            self.imageView.image = selectedImage
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func configureView(){
        if let college = self.detailItem{
            if nameTextField != nil{
                nameTextField.text = college.name
                locationTextField.text = college.location
                enrollmentTextField.text = String(college.enrollment)
                imageView.image = UIImage(data: college.image)
                websiteTextField.text = college.website
            }
        }
    }

    @IBAction func onTappedSaveButton(_ sender: Any) {
        if let college = self.detailItem{
            try! realm.write({
                college.name = nameTextField.text!
                college.location = locationTextField.text!
                college.enrollment = Int(enrollmentTextField.text!)!
                college.image = UIImagePNGRepresentation(imageView.image!)!
                college.website = websiteTextField.text!
            })
        }
        
    }
    //does the following go in master or detail?
         @IBAction func onGoButtonTapped(_ sender: Any) {
            let urlString = "https://" + websiteTextField.text!
        let url = URL(string: urlString)
        let svc = SFSafariViewController(url: url!)
        present(svc, animated: true, completion: nil)
    }
    @IBAction func onChangeImageButtonTapped(_ sender: Any) {
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    

}

