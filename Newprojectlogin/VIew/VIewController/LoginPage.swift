//
//  LoginPage.swift
//  Newprojectlogin
//
//  Created by R95 on 30/04/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class LoginPage: UIViewController {
    
    let db =  Firestore.firestore()
    
    @IBOutlet weak var emailtextfield: UITextField!
    
    
    @IBOutlet weak var passwordtextfield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func loginActionButton(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailtextfield.text ?? "", password: passwordtextfield.text ?? ""){authResult, error in
            if (error == nil)
            {
                let naviget = self.storyboard?.instantiateViewController(withIdentifier: "TabViewController") as! TabViewController
                
                self.navigationController?.pushViewController(naviget, animated: true)
            }
            else
            {
                self.alert(title: "alert", message:  error?.localizedDescription ?? "")
            }
        }
    }
    
    
    func alert(title : String , message : String)
    {
        let a = UIAlertController(title: title, message: message, preferredStyle: .alert)
        a.addAction(UIAlertAction(title: "ok", style: .cancel))
        a.addAction(UIAlertAction(title: "cancle", style: .destructive))
        
        present(a, animated: true)
    }
    
    
    
    @IBAction func forgetactionButton(_ sender: Any) {
        
        let a = storyboard?.instantiateViewController(withIdentifier: "ForgetPassword1") as! ForgetPassword1
        
        navigationController?.pushViewController(a, animated: true)
        
        
    }
    
    
    
    
}
