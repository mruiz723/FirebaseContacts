//
//  ViewController.swift
//  FireBaseContacts
//
//  Created by S209e19 on 29/04/16.
//  Copyright © 2016 UdeM. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //MARK: - IBActions
    @IBAction func login(sender: AnyObject) {
        
        ref.authUser(userTextField.text, password: passwordTextField.text) { (error, auth) in
            
            if auth != nil{
                self.userTextField.text = ""
                self.passwordTextField.text = ""
                
                self.view.endEditing(true)
                
                self.performSegueWithIdentifier("Contacts", sender: nil)
            }else{
                
                let alert = UIAlertController(title: "Login", message: error.localizedDescription, preferredStyle: .Alert)
                
                let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                
                alert.addAction(okAction)
                
                self.presentViewController(alert, animated: true, completion: nil)
                
                
            }
            
        }
    }
    
    
    @IBAction func register(sender: AnyObject) {
        
        let alert = UIAlertController(title: "Registro", message: "Bienvenido a la creación de usuario", preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Guardar", style: .Default) { (action) in
            
            let emailTextField = alert.textFields![0]
            let passwordTextField = alert.textFields![1]
            
            emailTextField.becomeFirstResponder()
            
            self.ref.createUser(emailTextField.text, password: passwordTextField.text, withCompletionBlock: { (error) in
                
                if error == nil{
                    self.ref.authUser(emailTextField.text, password: passwordTextField.text, withCompletionBlock: { (error, auth) in
                        
                        if auth != nil{
                            self.performSegueWithIdentifier("Contacts", sender: nil)
                        }
                    })
                }
            })
            
        }
        
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .Default, handler: nil)
        
        alert.addTextFieldWithConfigurationHandler { (emailTextField) in
            
            emailTextField.placeholder = "Ingrese su email"
            
        }
        
        alert.addTextFieldWithConfigurationHandler { (passwordTextField) in
            
            passwordTextField.placeholder = "Ingrese su password"
            passwordTextField.secureTextEntry = true
            
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: - Properties
    var ref: Firebase!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        ref = Firebase(url: "https://contacsmruiz.firebaseio.com")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    
    
    
    


}

