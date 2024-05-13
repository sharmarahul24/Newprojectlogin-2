//
//  ForgetPassword1.swift
//  Newprojectlogin
//
//  Created by R92 on 01/05/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ForgetPassword1: UIViewController {
    
    let db = Firestore.firestore()
    var userUid = ""
    var email = ""
    
    

    @IBOutlet weak var emailtextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    


    @IBAction func forgetActionButton(_ sender: Any) {
//        Task { @MainActor in
//            let snapshot = try await db.collection("user").getDocuments()
//            
//            for document in snapshot.documents {
//                let email = document.data()["Email"]
//                if email as! String == emailtextfield.text ?? "" {
//                    print("true")
//                    userUid = document.documentID
//                    alert(title: "Done", message: "Your Email is Correct")
//                }
//            }
//        }
        
        Task { @MainActor in
            let snapshot = try await db.collection("user").getDocuments()
            
            for document in snapshot.documents {
                if let email = document.data()["Email"] as? String, let textFieldText = emailtextfield.text, email == textFieldText {
                    print("true")
                    userUid = document.documentID
                    alert(title: "Done", message: "Your Email is Correct")
                }
            }
        }
    }
    
    
    
    func alert(title:String,message:String){
        let a = UIAlertController(title: title, message: message, preferredStyle: .alert)
        a.addAction(UIAlertAction(title: "cancle", style: .cancel))
        
        a.addAction(UIAlertAction(title: "ok", style: .default,handler:
                                    { [self] _ in
            let c = self.storyboard?.instantiateViewController(identifier: "ResetPassword") as! ResetPassword
            c.userUID = userUid
            self.navigationController?.pushViewController(c, animated: true)
            
        }))
        present(a, animated: true)
    }
    
    
    
}
