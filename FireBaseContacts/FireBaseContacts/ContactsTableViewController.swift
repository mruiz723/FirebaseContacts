//
//  ContactsTableViewController.swift
//  FireBaseContacts
//
//  Created by S209e19 on 29/04/16.
//  Copyright © 2016 UdeM. All rights reserved.
//

import UIKit
import Firebase


class ContactsTableViewController: UITableViewController {
    
    //MARK: - Properties
    let cellIdentifier = "Contact"
    var contacts = [Contact]()
    var contact = Contact()
    var ref: Firebase!
    var handle: UInt!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        ref = Firebase(url: "https://contacsmruiz.firebaseio.com/Contacts")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        handle = ref.queryOrderedByKey().observeEventType(.Value, withBlock: { (snapshot) in
            
            if snapshot.exists(){
                self.contacts = [Contact]()
                for item in snapshot.children{
                    let contact = Contact(snapshot: item as! FDataSnapshot)
                    self.contacts.append(contact)
                }
                
                self.tableView.reloadData()
            }
        })
    }

    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        ref.removeObserverWithHandle(handle)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contacts.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)

        // Configure the cell...
        contact = contacts[indexPath.row]
        cell.textLabel!.text = contact.name
        cell.detailTextLabel?.text = contact.email
        
        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        contact = contacts[indexPath.row]
        performSegueWithIdentifier("Edit", sender: nil)
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Destructive, title: "Borrar" , handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
            
            self.contact = self.contacts[indexPath.row]
            
            let contactRef = self.ref.childByAppendingPath(self.contact.id)
            
            contactRef.removeValueWithCompletionBlock({ (error, ref) -> Void in
                
                if error != nil {
                    self.makeAlertWithMessage("Ha ocurrido un error al borrar")
                    print(error.localizedDescription)
                }else{
                    self.makeAlertWithMessage("El contacto ha sido borrado")
                }
                
            })
        })
        
        return [deleteAction]
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let destionationVC = segue.destinationViewController as? ContactViewController {
            
            if segue.identifier == "Edit" {
                destionationVC.contact = contact
                destionationVC.identifierView = "Edit"
            }else{
                destionationVC.identifierView = "Add"
            }
            
        }
        
    }
    
    // MARK: - Utils
    func makeAlertWithMessage(message: String) {
        
        let alert = UIAlertController(title: "Alerta", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler:nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }

}
