//
//  ChatTabView.swift
//  Newprojectlogin
//
//  Created by R92 on 01/05/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

struct ChatThread{
    var UID : [String]
    var threadUID : String
}

class ChatTabView: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let db = Firestore.firestore()
    var userarray : [ChatThread] = []
        var temp = 0
        var uid : String = ""
        var userUID = Auth.auth().currentUser?.uid ?? ""
    
    
    @IBOutlet weak var tableviewOutlet: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        getdata()
        
    }
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userarray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableviewOutlet.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChatTableViewCell
        let userstring = userarray[indexPath.row].UID[0]
        cell.namelableoutlet.text =  userstring
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = storyboard?.instantiateViewController(identifier: "ChatDidSelect") as? ChatDidSelect
        cell?.namelabel = userarray[indexPath.row].UID[1]
       
        navigationController?.pushViewController((cell)!, animated: true)
    }
    
    
    func getdata() {
        db.collection("chating").addSnapshotListener{ [self] snapshot, error  in
            
            if error == nil{
                if let snapshot = snapshot{
                    userarray = snapshot.documents.map{ i in
                        return ChatThread(UID: i["user"] as? [String] ?? ["nil"], threadUID: i["chating"] as? String ?? "")
                    }
                    print(userarray)
                    tableviewOutlet.reloadData()
                }
            }
            print(userarray)
            tableviewOutlet.reloadData()
        }
    }
}
