//
//  SettingTabView.swift
//  Newprojectlogin
//
//  Created by R92 on 01/05/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore


class SettingTabView: UIViewController {
    
    let db = Firestore.firestore()
    var userUID = Auth.auth().currentUser?.uid
    @IBOutlet weak var nameOutlet: UILabel!
    @IBOutlet weak var emailLableOutlet: UILabel!
    @IBOutlet weak var surnameLable: UILabel!
    @IBOutlet weak var logoutbuttonoutlet: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        print("======================================== \(userUID)")
        navigationItem.hidesBackButton = true

    }
    
    @IBAction func logOutActionButton(_ sender: Any) {
        
        nameOutlet.isHidden = true
        surnameLable.isHidden = true
        emailLableOutlet.isHidden = true
        getData()
        do{
            try Auth.auth().signOut()
            logoutAlert()
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func alert(title : String, message : String){
        let a = UIAlertController(title: title, message: message, preferredStyle: .alert)
        a.addAction(UIAlertAction(title: "Ok", style: .default,handler: { [self] a in
            let a = storyboard?.instantiateViewController(identifier: "StartPage") as! StartPage
            navigationController?.popViewController(animated: true)
        }))
        a.addAction(UIAlertAction(title: "Cencle", style: .cancel))
        present(a, animated: true)
    }
    
    func getData(){
        Task { @MainActor in
                
                let snapshot = try await self.db.collection("user").getDocuments()
                for document in snapshot.documents {
                    if userUID == document.documentID {
                        if let firstName = document.data()["First Name"] as? String,
                           let surname = document.data()["Last Name"] as? String,
                           let email = document.data()["Email"]{
                               nameOutlet.text = firstName
                               surnameLable.text = surname
                               emailLableOutlet.text = email as? String
                        } else {
                            print("123456")
                            
                            logoutbuttonoutlet.isHidden = false
                        }
                    }
                }
            
        }
    }
    
    func logoutAlert(){
        let a = UIAlertController(title: "Done !!", message: "Plz Restart Your App", preferredStyle: .alert)
        a.addAction(UIAlertAction(title: "Dismiss", style: .default))
        a.addAction(UIAlertAction(title: "Go to Sign in", style: .default, handler: { [self] a in
            let navigate = storyboard?.instantiateViewController(identifier: "StartPage") as! StartPage
            navigationController?.pushViewController(navigate, animated: true)
        }))
        present(a, animated: true)
    }
}





