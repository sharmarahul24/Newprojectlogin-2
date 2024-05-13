//
//  AddTabViewPage.swift
//  Newprojectlogin
//
//  Created by R92 on 01/05/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

struct UserDeatils{
    var UserUID: String
    var firstName : String
    var surName: String
}


class AddTabViewPage: UIViewController {
    
    
    
    let db = Firestore.firestore()
    var fullName = ""
    var array : [UserDeatils] = []
    var UID : String = ""
    var userUID = Auth.auth().currentUser?.uid ?? ""
    
    
    @IBOutlet weak var tableviewOutlet: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        getData()
    }

    //MARK: getdata function
    
    func getData(){
        db.collection("user").getDocuments{[self] snapshot,error in
            if error == nil {
                if let snapshot = snapshot {
                    array = snapshot.documents.map { i in
                        return UserDeatils(UserUID: i["UID"] as? String ?? "",firstName: i["First Name"] as? String ?? "" ,surName: i["Last Name"] as? String ?? "")
                    }
                    print(array)
                    tableviewOutlet.reloadData()
                }
            } else {
                print(error?.localizedDescription as Any)
            }
        }
    }
}
// MARK: Table View

extension AddTabViewPage :  UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableviewOutlet.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AddTableViewCell
        fullName = array[indexPath.row].firstName + " " + array[indexPath.row].surName
        cell.usernamelable.text = fullName
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if array[indexPath.row].UserUID == userUID {
            tabBarController?.selectedIndex = 1
        }
        else {
            let a = db.collection("chating").document()
            let dic = ["user" : [array[indexPath.row].UserUID,userUID],
                       "ThreadID": a.documentID,
                       "UserName": array[indexPath.row].firstName + " " + array[indexPath.row].surName] as [String : Any]
            a.setData(dic)
            array.remove(at: indexPath.row)
        }
        
        tableviewOutlet.reloadData()
        tabBarController?.selectedIndex = 0
    }
}
    
    

