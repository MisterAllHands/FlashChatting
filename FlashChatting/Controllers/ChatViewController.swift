//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
//Creating the database and storing it in the constant
    let db = Firestore.firestore()
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        tableView.dataSource = self
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        //Regitering the .xib file
        tableView.register(UINib(nibName: Const.cellNibName, bundle: nibBundle), forCellReuseIdentifier: Const.cellIdentifier)
        loadMessages()
        
//MARK: - loadMessages
        func loadMessages() {
                        
            //Creating object from the database
            db.collection(Const.FStore.collectionName)
            //Sorting out the messages depending on the time they were sent
                .order(by: Const.FStore.dateField)
            //Listening to the changes in the tableview and performing changes in the UITable
                .addSnapshotListener() { (querySnapshot, error) in
                
                self.messages = []
                
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    if let querySnapshotDocuments = querySnapshot?.documents{
                        for doc in querySnapshotDocuments {
                            let data = doc.data()
                            if let messageSender = data[Const.FStore.senderField] as? String, let messageBody =  data[Const.FStore.bodyField] as? String {
                                let newMessage = Message(sender: messageSender, body: messageBody)
                                self.messages.append(newMessage)
                                
                                //Updating rows of the tableview in the main thread after user sends a message.
                                DispatchQueue.main.async { [self] in
                                    self.tableView.reloadData()
                                    let indexPath = IndexPath(row: messages.count - 1, section: 0)
                                    tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                        }
                    }
                }
            }
        }
    }
}
//MARK: - logOutButton
    @IBAction func logOutButton(_ sender: UIBarButtonItem) {
        
        //Logging Out The Users
        //It throws an error, thus We used "do" and "catch" to catch the error.
        
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        }
        catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
        //Saving messages
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email{
            db.collection(Const.FStore.collectionName).addDocument(data: [
                Const.FStore.senderField: messageSender,
                Const.FStore.bodyField: messageBody,
                Const.FStore.dateField: Date().timeIntervalSince1970
            ]) {error in
                if let e = error {
                    print("Unsuccessful: Found Error (\(e)")
                }
            }
        }
        //Cleaning text field once the message was sent
        DispatchQueue.main.async {
            self.messageTextfield.text = ""
        }
    }
}

//MARK: - ChatViewController
extension ChatViewController: UITableViewDataSource {
    
    //Number of table rows depend on user messages.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    //All Messages will be send inside the MessageCell.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Const.cellIdentifier, for: indexPath) as! MessageCell
        cell.label.text = message.body
        
        //This is the message from the current user
        if message.sender == Auth.auth().currentUser?.email {
            cell.meImageView.isHidden = false
            cell.youImageView.isHidden = true
            cell.mainView.backgroundColor = UIColor(named: Const.BrandColors.lightPurple)
            cell.label.textColor = UIColor(named: Const.BrandColors.purple)
        }
        //This is the message from another user
        else{
            cell.meImageView.isHidden = true
            cell.youImageView.isHidden = false
            cell.mainView.backgroundColor = UIColor(named: Const.BrandColors.purple)
            cell.label.textColor = UIColor(named: Const.BrandColors.lightPurple)
        }
        //cell label, which is text of the message is going to be embaded into the MessageCell label
        
        return cell
    }
}
