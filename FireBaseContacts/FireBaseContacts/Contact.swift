//
//  Contact.swift
//  FireBaseContacts
//
//  Created by S209e19 on 29/04/16.
//  Copyright © 2016 UdeM. All rights reserved.
//

import Foundation
import Firebase

class Contact {
    
    //MARK: - Properties
    var id:String?
    var name:String?
    var lastName:String?
    var phone:String?
    var email:String?
    
    //MARK: - Init
    init(id:String, name:String, lastName:String, phone:String, email:String){
        self.id = id
        self.name = name
        self.lastName = lastName
        self.phone = phone
        self.email = email
    }
    
    convenience init(){
        self.init(id:"", name:"", lastName:"", phone:"", email:"")
    }
    
    convenience init(snapshot:FDataSnapshot){
        self.init(id:snapshot.key, name:snapshot.value["name"] as! String, lastName:snapshot.value["lastName"]as! String, phone:snapshot.value["phone"]as! String, email:snapshot.value["email"]as! String)
    }
 
    //MARK: - Utils
    func toDictionary() -> Dictionary<String,String> {
        return [
            "name": name!,
            "lastName": lastName!,
            "phone": phone!,
            "email": email!
        ]
    }
    
    
}
