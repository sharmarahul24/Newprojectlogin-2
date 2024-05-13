//
//  StartPage.swift
//  Newprojectlogin
//
//  Created by R95 on 30/04/24.
//

import UIKit

class StartPage: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    @IBAction func loginActionButton(_ sender: Any) {
        
        let a = storyboard?.instantiateViewController(withIdentifier: "LoginPage") as! LoginPage
        
        navigationController?.pushViewController(a, animated: true)
        
        
        
    }
    
    

    @IBAction func signinActionButton(_ sender: Any) {
        let navigate = storyboard?.instantiateViewController(withIdentifier: "Signuppage") as! Signuppage
        
        
        navigationController?.pushViewController(navigate, animated: true)
        
        
        
        
    }
    

}
