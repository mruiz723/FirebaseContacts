//
//  ContactViewController.swift
//  FireBaseContacts
//
//  Created by S209e19 on 29/04/16.
//  Copyright © 2016 UdeM. All rights reserved.
//

import UIKit
import Firebase

class ContactViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var lastNameLabel: UITextField!
    @IBOutlet weak var phoneLabel: UITextField!
    @IBOutlet weak var emailLabel: UITextField!
    
    // MARK: - IBActions
    @IBAction func save(sender: AnyObject) {
        
        
    }
    
    // MARK: - Properties
    var contact : Contact?
    var identifierView : String?
    var ref: Firebase?
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        ref = Firebase(url: "https://contacsmruiz.firebaseio.com/Contacts")
        
        self.nameLabel.text = contact?.name
        self.lastNameLabel.text = contact?.lastName
        self.phoneLabel.text = contact?.phone
        self.emailLabel.text = contact?.email
        
        
        if identifierView == "Edit" {
            self.title = "Detalle Contacto"
        }else{
            self.title = "Nuevo Contacto"
        }
            
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
