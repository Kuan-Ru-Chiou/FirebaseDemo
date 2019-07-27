//
//  LogonViewController.swift
//  FirebaseDemo
//

//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.title = "Log In"
        emailTextField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = ""
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    @ IBAction func login(sender: UIButton) {
        
        //輸入驗證
        guard let emailAddress = emailTextField.text, emailAddress != "",
            let password = passwordTextField.text, password != "" else {
                
                
                let alertController = UIAlertController(title: "Login error", message: "Both fields must not be blank", preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okayAction)
                present(alertController, animated: true, completion: nil)
                return
        }
        
        
        //呼叫 Firebase API 登入
        Auth.auth().signIn(withEmail: emailAddress, password: password, completion: { (user, error) in
            
            if let error =  error {
                
                let alertController = UIAlertController(title: "Login error", message: error.localizedDescription, preferredStyle: .alert)
                
                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okayAction)
                self.present(alertController, animated: true, completion: nil)
                
                return
                
            }
        
            
            
            //Email認證
            guard let currentUser = user, currentUser.user.isEmailVerified else {
                
                let alertController = UIAlertController(title: "Login error", message: "You have not confirmed your email address yet. We sent you a confirmation email when you sign up. Please click the link in that email. if you need us send the confirmation again, please tap Resend Email", preferredStyle: .alert)
                
                let okayAction = UIAlertAction(title: "Resend email", style: .default, handler: { (action) in user?.user.sendEmailVerification(completion: nil)
                })
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                
                alertController.addAction(okayAction)
                alertController.addAction(cancelAction)
                
                self.present(alertController, animated: true, completion: nil)
                
                return
                
            }
            
            
            
            
            
            
            
            
            
            //解除鍵盤
        self.view.endEditing(true)
            
            //呈現主視圖
            
            if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MainView") {
                UIApplication.shared.keyWindow?.rootViewController = viewController
                self.dismiss(animated: true, completion: nil)
                
                
            }
        
        
        
    })
    
    
    
    
    
    
    
    
}
}
