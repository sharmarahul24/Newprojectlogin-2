//
//  Signuppage.swift
//  Newprojectlogin
//
//  Created by R95 on 30/04/24.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import GoogleSignIn


class Signuppage: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailtextfield: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    
    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func signUpButtonAction(_ sender: Any) {
        Auth.auth().createUser(withEmail: emailtextfield.text ?? "", password: passwordTextField.text ?? "") { [self] authResult, error in
                if error == nil {
                    let dec = ["First Name": nameTextField.text ?? ""
                               ,"Last Name": surnameTextField.text ?? ""
                               ,"Email": emailtextfield.text ?? ""
                               ,"Password": passwordTextField.text ?? ""
                               ,"Moblie Number": mobileNumberTextField.text ?? ""
                               ,"Age" : ageTextField.text ?? ""
                               ,"UID":Auth.auth().currentUser?.uid ?? ""] as [String : Any]
                     
                    db.collection("user").document(Auth.auth().currentUser?.uid ?? "").setData(dec)
                    alert(title: "Successfully!", message: "Sign Up successfully")
                }
                else {
                    alert(title: "Error!", message: error?.localizedDescription ?? "nil")
                }
            }
        }
    
    
    
    func alert(title : String , message : String)
    {
        let a = UIAlertController(title: title, message: message, preferredStyle: .alert)
        a.addAction(UIAlertAction(title: "ok", style: .cancel))
        a.addAction(UIAlertAction(title: "cancle", style: .destructive))
        naviget()
        
        present(a, animated: true)
    }
    
    
    
    func naviget ()
    {
        let a = storyboard?.instantiateViewController(withIdentifier: "LoginPage") as! LoginPage
        
        navigationController?.pushViewController(a, animated: true)
        
    }
    
    @IBAction func googleSignupButtonAction(_ sender: Any) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
            if error == nil {
                let user = result?.user
                let idToken = user?.idToken?.tokenString

                let credential = GoogleAuthProvider.credential(withIDToken: idToken ?? "",
                                                               accessToken: user?.accessToken.tokenString ?? "")

                Auth.auth().signIn(with: credential) { [self] result, error in
                    if error == nil {
                        alert(title: "Successfully!", message: "Sign Up successfully")
                    }
                    else if error != nil {
                        alert(title: "Error!", message: error?.localizedDescription ?? "")
                    }
                }
            }
            else {
                alert(title: "Error!", message: "***")
            }
        }
    }
}




