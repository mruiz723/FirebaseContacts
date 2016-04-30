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
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    // MARK: - IBActions
    @IBAction func save(sender: AnyObject) {
        if nameTextField.text?.characters.count > 0 {
            
            if identifierView == "Add" {
                
                let contact = Contact(id: "0", name: nameTextField.text!, lastName: lastNameTextField.text!, phone: phoneTextField.text!, email: emailTextField.text!)
                
                // create a child reference with unique id
                let contactRef = ref!.childByAutoId()
                
                contactRef.setValue(contact.toDictionary(), withCompletionBlock: { (error, ref) in
                    if error != nil {
                        self.makeAlertWithMessage("Ha ocurrido un error al guardar el contacto")
                    }else{
                        self.makeAlertWithMessage("Su contacto ha sido guardado")
                    }
                })
                
            }else{
                
                contact.name = self.nameTextField.text!
                contact.lastName = self.lastNameTextField.text!
                contact.phone = self.phoneTextField.text!
                contact.email = self.emailTextField.text!
                
                let contactRef = ref!.childByAppendingPath(contact.id)
                
                contactRef?.updateChildValues(contact.toDictionary(), withCompletionBlock: { (error, ref) in
                    if error != nil {
                        self.makeAlertWithMessage("Ha ocurrido un error al actualizar")
                    }else{
                        self.makeAlertWithMessage("Su contacto ha sido actualizado")
                    }
                })
            }
            
        }else{
            self.makeAlertWithMessage("El campo de texto nombre es requerido para poder actualizar un contacto")
        }
        
    }
    
    // MARK: - Properties
    var contact = Contact()
    var identifierView : String?
    var ref: Firebase?
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        ref = Firebase(url: "https://contacsmruiz.firebaseio.com/Contacts")
        
        self.nameTextField.text = contact.name
        self.lastNameTextField.text = contact.lastName
        self.phoneTextField.text = contact.phone
        self.emailTextField.text = contact.email
        
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
    
    // MARK: - Utils
    func makeAlertWithMessage(message: String) {
        
        let alert = UIAlertController(title: "Alerta", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) -> Void in
            
            self.navigationController?.popViewControllerAnimated(true)
            
        }))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
}
