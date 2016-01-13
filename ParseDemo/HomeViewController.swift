//
//  HomeViewController.swift
//  ParseDemo
//

import UIKit
import Parse

class HomeViewController: UIViewController {
    //@IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postTextView.layer.borderColor = UIColor.blackColor().CGColor
        postTextView.layer.borderWidth = 0.5
        postTextView.layer.cornerRadius = 5
        postTextView.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        if (PFUser.currentUser() == nil) {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in

                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Login") 
                self.presentViewController(viewController, animated: true, completion: nil)
            })
        }
    }
    @IBAction func postAction(sender: AnyObject){
        let post:PFObject = PFObject(className: "Posts")
        post["content"] = postTextView.text
        post["user"] = PFUser.currentUser()
        post.saveInBackground()
        self.navigationController!.popToRootViewControllerAnimated(true)
    }
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
