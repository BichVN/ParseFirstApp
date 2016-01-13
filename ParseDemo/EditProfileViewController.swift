//
//  EditProfileViewController.swift
//  ParseFirstApp
//
//  Created by Bich Vu Ngoc on 1/10/28 H.
//  Copyright © 28 Heisei abearablecode. All rights reserved.
//

import UIKit
import Parse

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var profilePictureImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    let username = PFUser.currentUser()?.objectForKey("username") as! String
        
    userNameTextField.text = username
    
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func chooseAvatar(sender: AnyObject) {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(myPickerController, animated: true, completion: nil)
    }
    @IBAction func doneButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }

    
    @IBAction func saveChangeButtonTapped(sender: AnyObject) {
        let currentUser = PFUser.currentUser()!
        let profileImageData = UIImageJPEGRepresentation(profilePictureImageView.image!, 1)
        
        if userNameTextField.text!.isEmpty && passwordTextField.text!.isEmpty && profileImageData == nil {
            
            let myAlert = UIAlertController(title: "Alert", message: "All field cannot be empty", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            myAlert.addAction(okAction)
            self.presentViewController(myAlert, animated: true, completion: nil)
            return
        }
        
        if userNameTextField.text!.isEmpty {
            
            let myAlert = UIAlertController(title: "Alert", message: "username is required fields", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            myAlert.addAction(okAction)
            self.presentViewController(myAlert, animated: true, completion: nil)
            return
            
        }
        if (PFUser.currentUser()!.objectForKey("avatar") != nil) {
            
            let userImageFile = PFUser.currentUser()?.objectForKey("avatar") as! PFFile
            userImageFile.getDataInBackgroundWithBlock({(imageData: NSData?, error: NSError?)-> Void in
                self.profilePictureImageView.image = UIImage(data: imageData!)
            })
        }
        let username = userNameTextField.text
        currentUser.setObject(username!, forKey: "username")
        
        if(!passwordTextField.text!.isEmpty){
            let userPassword = passwordTextField.text
            currentUser.password = userPassword
        }
        
        //set avatar
        if profileImageData != nil {
            let profileFileObject = PFFile(data: profileImageData!)
            currentUser.setObject(profileFileObject, forKey: "avatar")
        }
        
        //Display activity indicator
        let loadingNotification = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
r        // Edit profile the user asynchronously
        currentUser.saveInBackgroundWithBlock({ (succeed, error) -> Void in
            //something to do
        })
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        profilePictureImageView.image = info [UIImagePickerControllerOriginalImage] as! UIImage
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
