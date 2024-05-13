//
//  chatDidsecelt.swift
//
//
//  Created by R92 on 02/05/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

struct ChatData {
    var message: String
    var sender: String
    var time: Date
    var dataType: String
    var imagePath: String
    
    init(dic: QueryDocumentSnapshot) {
        self.message = dic["Message"] as? String ?? "nil mesg"
        self.sender = dic["Sender"] as? String ?? "nil sender"
        self.time = (dic["Time"] as! Timestamp).dateValue()
        self.dataType = dic["dataTpye"] as? String ?? "nil datatype"
        self.imagePath = dic["imagePath"] as? String ?? "nil imagePath"
    }
}
    
    class ChatDidSelect: UIViewController {
        
        @IBOutlet weak var namelableoutlet: UILabel!
        
        
        @IBOutlet weak var chattextfield: UITextField!
        
        @IBOutlet weak var chattableview: UITableView!
        
        
        var namelabel = ""
        var threadID = ""
        var db = Firestore.firestore()
        var userArray = [ChatData]()
        var uid = Auth.auth().currentUser?.uid
        
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            namelableoutlet.text = namelabel
            getData()
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.tabBarController?.tabBar.isHidden = true
        }
        
@IBAction func sendButtonAction(_ sender: Any) {
            let dic = ["Message": chattextfield.text as Any,
                       "Time": Date(),
                       "Sender": uid as Any,
                       "dataTpye": "Message",
                       "imagePath": ""]
            
            db.collection("chating").document(threadID).collection("Chat").addDocument(data: dic) { [self] error in
                if error == nil {
                    chattextfield.text = ""
                }
            }
        }
        
        func getData() {
            db.collection("chating").document(threadID).collection("Chat").order(by: "Time", descending: false).addSnapshotListener { [self] snapShot, error in
                if let snapshot = snapShot {
                    userArray = snapshot.documents.map { i in ChatData(dic: i) }
                    print(userArray)
                    chattableview.reloadData()
                }
            }
        }
        
        //MARK: Keyboard Code
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            view.endEditing(true)
        }
        
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return userArray.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = chattableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Usertableviewcell
            
            let message = userArray[indexPath.row].message
            cell.messegelableoutlet.text = message
            
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 110
        }
        
        
        
    }
    
    











