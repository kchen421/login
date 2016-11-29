//
//  ViewController.swift
//  Login
//
//  Created by Katharine Chen on 11/14/16.
//  Copyright © 2016 Katharine Chen. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

class CreateSignIn: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var CreateEmail: UITextField!
    @IBOutlet var CreatePassword: UITextField!

    @IBOutlet var SignEmail: UITextField!


    @IBOutlet var SignPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func CreateAccountAction(_ sender: Any) {
        if self.CreateEmail.text == "" || self.CreatePassword.text == ""
        {
            let alertController = UIAlertController(title: "Oops!", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        else
        {
            guard let email = CreateEmail.text, let password = CreatePassword.text else {
                print("Form is not valid")
                return
            }            
            FIRAuth.auth()?.createUser(withEmail: self.CreateEmail.text!, password: self.CreatePassword.text!, completion: { (user, error) in
                
                if error == nil
                {
                    self.CreateEmail.text = ""
                    self.CreatePassword.text = ""
                }
                else
                {
                    let alertController = UIAlertController(title: "Oops!", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
                
                let ref = FIRDatabase.database().reference(fromURL: "https://trial-project-80879.firebaseio.com/")
                
                guard let uid = user?.uid else {
                    return
                }                
                
                let usersReference = ref.child("users").child(uid)
                let values = ["email": email]
                usersReference.updateChildValues(values, withCompletionBlock: { (error, ref) in
                    
                    if error != nil {
                        print("error")
                        return
                    }
                    })
            })
        }
    }
    
    @IBAction func SignInAction(_ sender: Any) {
        if self.SignEmail.text == "" || self.SignPassword.text == ""
        {
            let alertController = UIAlertController(title: "Oops!", message: "Please enter your email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        else
        {
            guard let email = SignEmail.text, let password = SignPassword.text else {
                print("Form is not valid")
                return
            }
            
            FIRAuth.auth()?.signIn(withEmail: self.SignEmail.text!, password: self.SignPassword.text!, completion: { (user, error) in
                
                if error == nil
                {
                    self.CreateEmail.text = ""
                    self.CreatePassword.text = ""
                }
                else
                {
                    let alertController = UIAlertController(title: "Oops!", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
                
                let ref = FIRDatabase.database().reference(fromURL: "https://trial-project-80879.firebaseio.com/")
                
                guard let uid = user?.uid else {
                    return
                }
            })
            
        }
    }
}

class Arnold: UIViewController, UITextFieldDelegate {
    
    var ref = FIRDatabase.database().reference()
    
    // My Profile
    @IBOutlet var ScrollView: UIScrollView!
    
    @IBOutlet var Name: UITextField!
    @IBOutlet var Birthday: UITextField!
    @IBOutlet var Gender: UITextField!
    @IBOutlet var Quote: UITextField!
    @IBOutlet var Facebook: UITextField!
    @IBOutlet var Twitter: UITextField!
    @IBOutlet var Instagram: UITextField!
    @IBOutlet var Email: UITextField!
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField == Facebook)
        {
        ScrollView.setContentOffset(CGPoint (x: 0, y: 250), animated: true)
        }
        if (textField == Twitter)
        {
            ScrollView.setContentOffset(CGPoint (x: 0, y: 250), animated: true)
        }
        if (textField == Instagram)
        {
            ScrollView.setContentOffset(CGPoint (x: 0, y: 250), animated: true)
        }
        if (textField == Email)
        {
            ScrollView.setContentOffset(CGPoint (x: 0, y: 250), animated: true)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        ScrollView.setContentOffset(CGPoint (x: 0, y: 0), animated: true)
    }
    
    @IBOutlet var didTapDone: UIButton!
    
    
    
    
    
    
    // CameraView
    @IBOutlet var NameField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // View Profile
    
    @IBAction func LogoutAction(_ sender: Any) {
        try! FIRAuth.auth()?.signOut()
    }
}

class TextField: UITextField, UITextFieldDelegate {
    
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10);
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
}
