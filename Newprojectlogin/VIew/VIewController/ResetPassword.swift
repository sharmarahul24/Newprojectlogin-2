//
//  ResetPassword.swift
//  Newprojectlogin
//
//  Created by R92 on 01/05/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ResetPassword: UIViewController {
    
    let db = Firestore.firestore()
    var userUID = ""
    

    @IBOutlet weak var newpasswordTextField: UITextField!
    
    
    @IBOutlet weak var ConfirmPasswordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       

       
    }
    
    @IBAction func newPasswordActionButton(_ sender: Any) {
            Task { @MainActor in
                let snapshot = try await self.db.collection("user").getDocuments()
                for document in snapshot.documents {
                    if userUID == document.documentID {
                        if newpasswordTextField.text == ConfirmPasswordTextField.text {
                            let passwordCange = ["Password": ConfirmPasswordTextField.text]
                            try await db.collection("user").document(userUID).setData(passwordCange, merge: true)
                            passwordChange()
                           print("password was changed")
                        }
                    }
                }
            }
       
        }
        
        func passwordChange() {
            Auth.auth().currentUser?.updatePassword(to: ConfirmPasswordTextField.text ?? "") { error in
                if error == nil {
                    print("true")
                }
                else {
                    print("false")
                }
            }
        }
    
    func alert(title:String,message:String){
        let a = UIAlertController(title: title, message: message, preferredStyle: .alert)
        a.addAction(UIAlertAction(title: "cancle", style: .cancel))
        
        a.addAction(UIAlertAction(title: "ok", style: .default))
        present(a, animated: true)
    }
    
}
